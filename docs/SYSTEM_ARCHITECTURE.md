# System Architecture

## Stack

The current law-team stack is:

1. `Corpus`
2. `Kernel Team`
3. `Reasoning Fabric`
4. `Trust Deed Module`
5. `WORM Seal Path`

## Module Boundaries

### Corpus

Stores the training and doctrine surface. Shared by all kernels.

### Kernel Team

- `carto_kernel`
- `cobol_law_kernel`
- `rexx_glue_kernel`

Each kernel reads the same corpus with a different logic profile.

### Reasoning Fabric

Owns:

- engine registry
- summon envelopes
- FSM transition path
- meta-lawyer spawn profiles

### Trust Deed Module

Owns:

- deed template registry
- deed generator
- governance gate
- escalation and authority checks

## Runtime Separation

### Prolog

Used for declarative legal rules and authority facts.

### COBOL

Used for procedure-shaped legal business output.

### REXX

Used for glue, routing, and operator scripting.

### Rust

Used for the Nemotron/Tokio FSM scaffold.

### JavaScript

Used for summon envelopes, deed generation, and frontend interaction.

## Production Boundaries

Safe production claims today:

- module boundaries are explicit
- registries are explicit
- cherry-pick manifests exist

Not safe to claim today:

- live external engine orchestration
- live signed deed issuance workflow
- live WORM append target
