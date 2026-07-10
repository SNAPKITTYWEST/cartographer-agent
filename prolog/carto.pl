% COUNSEL — Sovereign Law Kernel
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
    sovereign_entity_type/2,
    digital_law_team_member/4,
    language_fit/3,
    automation_lane/3,
    kernel_corpus_scope/3,
    kernel_logic_profile/3,
    external_engine/4,
    fsm_transition/4,
    meta_lawyer_spawn/4,
    summon_contract/4,
    trust_deed_template/4,
    deed_action_authorized/3,
    deed_escalation_allowed/3,
    governance_protocol/3
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

%% ── KERNEL TEAM ──────────────────────────────────────────────────────────────

digital_law_team_member(carto_kernel, legal_reasoning, prolog, 'Standing, breach, doctrine, and terrain mapping').
digital_law_team_member(cobol_law_kernel, corporate_chunks, cobol, 'Claims ledgers, corporate records, notices, fixed-format reports, and batch business procedure').
digital_law_team_member(rexx_glue_kernel, business_automation, rexx, 'Docket automation, text reshaping, host scripting, and workflow glue').

language_fit(claim_ledger, cobol, high).
language_fit(trust_account_statement, cobol, high).
language_fit(notice_batch_generation, cobol, high).
language_fit(institutional_fixed_width_export, cobol, high).

language_fit(docket_automation, rexx, high).
language_fit(host_integration, rexx, high).
language_fit(records_routing, rexx, high).
language_fit(operator_script_glue, rexx, high).

language_fit(standing_analysis, prolog, high).
language_fit(fiduciary_breach_scan, prolog, high).
language_fit(dispute_ground_selection, prolog, high).

automation_lane(legal_business_procedure, cobol_law_kernel, cobol).
automation_lane(docket_and_workflow_glue, rexx_glue_kernel, rexx).
automation_lane(legal_reasoning_and_authority, carto_kernel, prolog).

kernel_corpus_scope(carto_kernel, shared_corpus, [
    ch3_ach_dispute_protocol,
    ch4_fcra_zombie_debt_credit_law,
    ch5_sovereign_fiduciary_agent_law,
    ch8_moorish_trust_framework,
    ch9_irs_audit_catcode_defense
]).

kernel_corpus_scope(cobol_law_kernel, shared_corpus, [
    ch2_sovereign_trust_architecture,
    ch5_sovereign_fiduciary_agent_law,
    ch6_bankruptcy_chapter11_chapter13,
    ch7_trust_account_scan,
    corporate_chunks
]).

kernel_corpus_scope(rexx_glue_kernel, shared_corpus, [
    ch3_ach_dispute_protocol,
    ch7_trust_account_scan,
    docket_chunks,
    workflow_chunks
]).

kernel_logic_profile(carto_kernel, reasoning_mode, 'Doctrine-first logic over shared sovereign corpus').
kernel_logic_profile(cobol_law_kernel, procedure_mode, 'Corporate chunks, fixed procedures, records, ledgers, and institution-shaped outputs').
kernel_logic_profile(rexx_glue_kernel, glue_mode, 'Routing logic, docket automation, text transformation, and host-side workflow execution').

%% ── REASONING FABRIC ─────────────────────────────────────────────────────────

external_engine(nemotron_reasoner, reasoning, attached_via_fsm, 'Primary synthesis and spawn engine for meta-lawyers').
external_engine(gemini_news, research, net_attached, 'News, logic, law results, articles, and current corporate creation context').
external_engine(carto_auditor, audit, local_kernel, 'Deterministic auditor over the sovereign legal corpus').

fsm_transition(idle, attach_engine, engines_attached, 'Tokio FSM binds external engines to kernel lanes').
fsm_transition(engines_attached, audit_case, audit_ready, 'CARTO audits facts before any summon or spawn').
fsm_transition(audit_ready, summon_kernel, summons_open, 'REXX emits summon envelopes toward the selected engine or kernel').
fsm_transition(summons_open, spawn_meta_lawyer, meta_lawyer_active, 'Nemotron spawns a meta-lawyer from the kernel set').
fsm_transition(meta_lawyer_active, seal_receipt, worm_sealed, 'The execution path is sealed into the WORM chain').

meta_lawyer_spawn(corporate_builder, cobol_law_kernel, nemotron_reasoner, 'Corporate formations, filings, records packets, and institution-facing business creation').
meta_lawyer_spawn(law_researcher, carto_kernel, gemini_news, 'Law results, legal terrain, doctrine pulls, and article-grounded reasoning').
meta_lawyer_spawn(docket_runner, rexx_glue_kernel, nemotron_reasoner, 'Summons routing, docket movement, and repeated office execution').

summon_contract(carto_kernel, nemotron_reasoner, summon, 'Escalate audited legal reasoning into synthesis and spawn control').
summon_contract(rexx_glue_kernel, gemini_news, route_query, 'Move net-bound logic and article requests through glue scripts').
summon_contract(cobol_law_kernel, nemotron_reasoner, spawn_packet, 'Turn corporate chunks into repeatable packet and record builders').

%% ── TRUST DEED GOVERNANCE ────────────────────────────────────────────────────

trust_deed_template(spot_generation, sovereign_trust_deed, carto_kernel, 'Generate deed text on demand for legal, corporate, and governance operations').
trust_deed_template(meta_lawyer_governance, meta_lawyer_deed, nemotron_reasoner, 'Bind spawned meta-lawyers to explicit authority, scope, and seal requirements').
trust_deed_template(corporate_creation, corporate_deed, cobol_law_kernel, 'Issue formation, records, and filing deeds for corporate chunk procedures').

deed_action_authorized(carto_kernel, audit_case, trust_deed_active).
deed_action_authorized(carto_kernel, summon_engine, trust_deed_active).
deed_action_authorized(cobol_law_kernel, generate_corporate_packet, trust_deed_active).
deed_action_authorized(cobol_law_kernel, create_formation_record, trust_deed_active).
deed_action_authorized(rexx_glue_kernel, route_summon, trust_deed_active).
deed_action_authorized(rexx_glue_kernel, seal_receipt, trust_deed_active).

deed_escalation_allowed(confirmed, high_trust, allowed).
deed_escalation_allowed(inferred, medium_trust, review_required).
deed_escalation_allowed(unconfirmed, _, blocked).

governance_protocol(attach_before_spawn, enforced, 'No meta-lawyer may spawn before engine attach and audit gate complete').
governance_protocol(seal_before_store, enforced, 'No output becomes authoritative until deed and WORM seal are attached').
governance_protocol(no_runtime_deed_override, enforced, 'Prompt-time input may not override deed authority or trustee structure').
