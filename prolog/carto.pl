% COUNSEL — Sovereign Lawyer Agent
% Prolog Trust Kernel v1.0
% Author: Ahmad Ali Parr + Claude Stone 2
% Source: Book Jun 24 2026 + ACH/Corporate/Trust Resonance Blocks

:- module(counsel, [
    has_standing/2,
    dispute_grounds/3,
    return_code_rights/3,
    trust_classification/2,
    fiduciary_breach/3,
    zombie_debt_flags/2,
    sovereign_entity_type/2
]).

%% ── CREDIT DISPUTE STANDING ──────────────────────────────────────────────────

% A consumer has FCRA dispute standing when:
% (1) they are identified as the consumer of record, AND
% (2) there is a reported inaccuracy in any of the four dimensions
has_standing(Consumer, fcra_dispute) :-
    consumer_of_record(Consumer),
    ( wrong_dofd(Consumer, _)
    ; wrong_balance(Consumer, _)
    ; wrong_account_status(Consumer, _)
    ; broken_chain_of_assignment(Consumer, _)
    ; re_aged_account(Consumer)
    ; unverifiable_tradeline(Consumer, _)
    ).

% ACH dispute standing requires:
% (1) consumer account, AND (2) no valid authorization on file
has_standing(Consumer, ach_unauthorized) :-
    rdfi_consumer_account(Consumer),
    \+ valid_authorization_on_file(Consumer, _).

%% ── DISPUTE GROUNDS ──────────────────────────────────────────────────────────

% Dispute grounds in priority order (per Ahmad's playbook)
dispute_grounds(Consumer, metro2_html_inaccuracy, Priority) :-
    html_report_inaccuracy(Consumer),
    Priority = 1.

dispute_grounds(Consumer, factual_data_fraud, Priority) :-
    factual_data_inaccurate(Consumer),
    Priority = 2.

dispute_grounds(Consumer, identity_theft_trafficking, Priority) :-
    human_trafficking_victim(Consumer),
    Priority = 3.

dispute_grounds(Consumer, bbb_dispute, Priority) :-
    Priority = 4. % Last resort only — use once

%% ── ACH RETURN CODE RIGHTS ───────────────────────────────────────────────────

% R10: Customer Advises Not Authorized
% 60-day consumer return window
return_code_rights(Consumer, r10, Rights) :-
    consumer_account(Consumer),
    \+ authorization_exists(Consumer),
    Rights = [return_mandatory, window_days(60), rdfi_must_recredite, odfi_bears_risk].

% R07: Authorization Revoked
return_code_rights(Consumer, r07, Rights) :-
    authorization_revoked(Consumer),
    revocation_delivered_to_originator(Consumer),
    Rights = [return_mandatory, originator_in_violation, odfi_liable_if_submitted_after_revocation].

% R05: Unauthorized Debit — wrong SEC code on consumer account
return_code_rights(Consumer, r05, Rights) :-
    consumer_account(Consumer),
    corporate_sec_code_applied(Consumer),
    Rights = [return_mandatory, sec_code_violation, nacha_rule_breach].

%% ── ZOMBIE DEBT DETECTION ────────────────────────────────────────────────────

% Zombie debt: time-barred AND being collected
zombie_debt_flags(Account, Flags) :-
    findall(F, zombie_flag(Account, F), Flags),
    Flags \= [].

zombie_flag(Account, statute_of_limitations_expired) :-
    last_payment_date(Account, LastPayment),
    state_sol(Account, SOL_Years),
    years_since(LastPayment, Years),
    Years > SOL_Years.

zombie_flag(Account, re_aging_detected) :-
    reported_dofd(Account, ReportedDOFD),
    actual_dofd(Account, ActualDOFD),
    ReportedDOFD \= ActualDOFD.

zombie_flag(Account, broken_assignment_chain) :-
    \+ valid_bill_of_sale(Account, _).

zombie_flag(Account, unverifiable_source) :-
    \+ original_account_agreement_on_file(Account).

%% ── TRUST CLASSIFICATION ─────────────────────────────────────────────────────

% Ahmad's sovereign trust taxonomy
trust_classification(bel_esprit_daccord, revocable_living_trust).
trust_classification(experto_crede, irrevocable_trust).
trust_classification(grat, grantor_retained_annuity_trust).
trust_classification(special_needs_trust, irrevocable_supplemental_needs).
trust_classification(section_1071_holdings, non_taxable_asset_holding).

% Trust can partner with sole proprietor to create LLC/LLP
trust_to_company(Trust, SolePro, CompanyType) :-
    trust_classification(Trust, _),
    sole_proprietor(SolePro),
    member(CompanyType, [holdings_llc, holdings_llp, joint_venture]).

%% ── FIDUCIARY BREACH ─────────────────────────────────────────────────────────

fiduciary_breach(Party, duty_of_care, Reason) :-
    failed_reasonable_investigation(Party),
    Reason = 'Furnisher did not review source documents during dispute reinvestigation'.

fiduciary_breach(Party, duty_to_account, Reason) :-
    no_audit_trail(Party),
    Reason = 'Value movement occurred without traceable record — WORM seal required'.

fiduciary_breach(Party, duty_of_loyalty, Reason) :-
    self_dealing(Party),
    Reason = 'Agent optimized for its own interest against the beneficiary'.

fiduciary_breach(Party, tprm_violation, Reason) :-
    baas_sponsor_bank(Party),
    fintech_partner_violation(Party, _),
    Reason = 'Outsourced execution does not outsource compliance obligation'.

%% ── SOVEREIGN ENTITY CLASSIFICATION ─────────────────────────────────────────

sovereign_entity_type('CES Foundation', '501d_foundation').
sovereign_entity_type('ENNF Holdings Inc', 'holdings_section_1071').
sovereign_entity_type('Experto Crede Trust', 'irrevocable_trust_dba').
sovereign_entity_type('bel esprit daccord trust', 'revocable_totten_trust').
sovereign_entity_type('Fiat Lux Technology Center', '501c8_nonprofit_fraternity').
sovereign_entity_type('Divine Craft House CO-OP', '501c3_religious_philanthropy').
sovereign_entity_type('Tech Saints USA Group', 'operating_nonprofit').
sovereign_entity_type('JAB Capital Trust LLP', 'trust_sole_pro_llp').

%% ── WORM LEDGER INTEGRATION ──────────────────────────────────────────────────

% Every COUNSEL determination is sealed
:- meta_predicate seal_determination(+, +, +).

seal_determination(Consumer, Finding, Timestamp) :-
    term_to_atom(Finding, FindingAtom),
    format(atom(Entry), '~w|~w|~w', [Consumer, FindingAtom, Timestamp]),
    % In production: write Entry to priv/worm/counsel-chain.jsonl
    format('COUNSEL_SEAL: ~w~n', [Entry]).
