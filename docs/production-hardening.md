# Production Hardening

This repo is now separated into three law-team modules:

1. `Kernel Team`
2. `Reasoning Fabric`
3. `Trust Deed Module`

## What Is Hardened

- kernel responsibilities are separated
- engine attachment and summon flow are separated from deed governance
- module manifests make cherry-picking into a dedicated repo straightforward
- runtime registries are explicit

## What Is Still Scaffolded

- live external engine bindings
- live WORM persistence
- frontend deed-generation flow
- runtime verification tests

## Cherry-Pick Shape

If this becomes a dedicated repo, lift these paths first:

- `kernels/`
- `runtime/`
- `prolog/carto.pl`
- `docs/digital-law-team.md`
- `docs/reasoning-fabric.md`
- `docs/trust-deed-module.md`
- `modules/`
- `snapkitty-law-team.manifest.json`

## Production Order

1. bind WORM persistence
2. bind external engine calls
3. add runtime tests for governance and FSM transitions
4. add UI deed generator and summon controls
5. cut dedicated repo only after the above stops changing daily
