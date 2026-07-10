# Trust Deed Module

The trust deed module sits above the reasoning fabric.

## Purpose

- generate trust deeds on the spot
- bind spawned meta-lawyers to explicit authority
- govern corporate creation flows
- stop unauthorized summon, spawn, or store actions

## Runtime Shape

- `trust-deed-generator.mjs` builds deed payloads
- `trust-deed-registry.json` stores deed templates and active deed classes
- `governance-gate.mjs` enforces deed checks before action
- `carto.pl` declares authority predicates for runtime and audit use

## Deed Classes

- `sovereign_trust_deed`
- `corporate_deed`
- `meta_lawyer_deed`

## Governance Protocol

1. generate deed
2. attach deed to action path
3. audit case
4. authorize summon or packet creation
5. spawn only if deed and escalation pass
6. seal receipt into WORM
