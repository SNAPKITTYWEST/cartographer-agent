# CARTO — Cartographer Agent
## Sovereign Law Engine · SnapKitty Collective

CARTO maps the legal terrain. 66 training entries across 9 chapters of sovereign law knowledge, with a kernel team for reasoning, procedure, and workflow glue.

**Partner:** [VAULT Fundability Engine](https://snapkittywest.github.io/vault-fundability-engine/)
**Live:** [snapkittywest.github.io/cartographer-agent](https://snapkittywest.github.io/cartographer-agent/)
**Contact:** devops@collectivekitty.com

---

## Overview

CARTO is the legal side of the SnapKitty stack. It is built as a layered system:

1. a sovereign legal corpus
2. a three-kernel law team
3. a reasoning fabric for engine attach and meta-lawyer spawn
4. a trust deed governance layer
5. a WORM-sealed output path

The repo is now structured so those parts can stay together here or be cherry-picked into a dedicated `snapkitty-law-team` repo later.

## Guides

- [docs/USER_GUIDE.md](docs/USER_GUIDE.md)
- [docs/SYSTEM_ARCHITECTURE.md](docs/SYSTEM_ARCHITECTURE.md)
- [docs/FRONTEND_GUIDE.md](docs/FRONTEND_GUIDE.md)
- [docs/SHAKESPEAREAN_LAYER.md](docs/SHAKESPEAREAN_LAYER.md)
- [docs/digital-law-team.md](docs/digital-law-team.md)
- [docs/reasoning-fabric.md](docs/reasoning-fabric.md)
- [docs/trust-deed-module.md](docs/trust-deed-module.md)
- [docs/production-hardening.md](docs/production-hardening.md)

## Corpus Chapters

| Ch | Domain | Entries |
|----|--------|---------|
| 1 | Credit Repair Mastery | 9 |
| 2 | Sovereign Trust Architecture | 8 |
| 3 | ACH Dispute Protocol | 7 |
| 4 | FCRA / Metro 2 / Zombie Debt | 7 |
| 5 | Sovereign Fiduciary + Agent Law | 7 |
| 6 | Bankruptcy Ch. 11 / Ch. 13 | 7 |
| 7 | Trust Account Scan | 6 |
| 8 | Moorish Trust Framework | 6 |
| 9 | IRS Audit CatCode Defense | 5 |
| — | Evoked Personas + Kernel Team | 4 |

**Total: 66 training entries**

## Prolog Kernel

`prolog/carto.pl` — Constitutional court logic: `has_standing/2`, `dispute_grounds/3`, `return_code_rights/3`, `zombie_debt_flags/2`, `trust_classification/2`, `fiduciary_breach/3`, `sovereign_entity_type/2`

## Kernel Team

CARTO now carries a three-part execution layer for business-shaped legal work:

- `CARTO / Prolog Kernel` — legal reasoning and standing engine
- `COBOL Law Kernel` — procedural claim, corporate chunk, ledger, notice, and batch business operations
- `REXX Glue Kernel` — business automation, host scripting, docket flow, and workflow glue

All three kernels share the CARTO corpus. What changes is the logic profile and the slice each kernel works against.

### Language Fit

- `COBOL`:
  corporate chunks, claim ledgers, trust account statements, notice batches, institutional fixed-width exports
- `REXX`:
  docket automation, host integration, records routing, operator script glue
- `Prolog`:
  standing, fiduciary breach, dispute grounds, sovereign entity classification

### Shared Corpus, Different Logic

- `Prolog` reads the corpus as doctrine, standing, breach, and legal terrain
- `COBOL` reads the corpus as corporate chunks, procedure, records, and institution-facing output
- `REXX` reads the corpus as routing, transformation, docket motion, and workflow glue

## Reasoning Fabric

The next layer is a Nemotron-style reasoning fabric on top of the kernels:

- `CARTO` stays the auditor
- `REXX` moves summons and routes requests to attached engines
- `Nemotron` handles synthesis and meta-lawyer spawning
- `Gemini News` supplies current law results, articles, corporate creation context, and net-facing research
- `Tokio FSM` controls attach -> audit -> summon -> spawn -> seal

Files:
- [runtime/nemotron-fsm.rs](runtime/nemotron-fsm.rs)
- [runtime/summon-envelope.mjs](runtime/summon-envelope.mjs)
- [runtime/engine-registry.json](runtime/engine-registry.json)
- [docs/reasoning-fabric.md](docs/reasoning-fabric.md)

## Trust Deed Module

Above the reasoning fabric sits the trust deed module:

- on-the-spot trust deed generation
- governance protocol for summon, spawn, and seal
- deed gating for corporate creation, legal escalation, and meta-lawyer authority

Files:
- [runtime/trust-deed-generator.mjs](runtime/trust-deed-generator.mjs)
- [runtime/trust-deed-registry.json](runtime/trust-deed-registry.json)
- [runtime/governance-gate.mjs](runtime/governance-gate.mjs)
- [docs/trust-deed-module.md](docs/trust-deed-module.md)

See:
- [docs/digital-law-team.md](docs/digital-law-team.md)
- [kernels/cobol-law-kernel.cob](kernels/cobol-law-kernel.cob)
- [kernels/rexx-glue-kernel.rexx](kernels/rexx-glue-kernel.rexx)

## Module Separation

This repo now separates the SnapKitty law team into three cherry-pickable modules:

- `Kernel Team`
- `Reasoning Fabric`
- `Trust Deed Module`

Module manifests:
- [modules/kernel-team.module.json](modules/kernel-team.module.json)
- [modules/reasoning-fabric.module.json](modules/reasoning-fabric.module.json)
- [modules/trust-deed.module.json](modules/trust-deed.module.json)
- [snapkitty-law-team.manifest.json](snapkitty-law-team.manifest.json)

Hardening notes:
- [docs/production-hardening.md](docs/production-hardening.md)

## Production State

Current state is `hardened scaffold`.

- boundaries and registries are explicit
- deed governance is separated from summon/spawn logic
- external engine bindings are still scaffolded
- WORM persistence is still stubbed
- GitHub Pages frontend scaffold is present for user interaction

## Frontend

The public frontend lives in:

- [docs/index.html](docs/index.html)

It is built to sit directly on GitHub Pages and explain the system visually while providing a static interaction scaffold for:

- kernel selection
- reasoning-fabric path
- trust deed path
- runtime status awareness

## Sovereign Source License v1.0
© 2026 Ahmad Ali Parr · Cannot be used to train commercial models without written license from the Principal.

![](https://sovereign-analytics.snapkittywest.workers.dev/canary/cartographer-agent)
