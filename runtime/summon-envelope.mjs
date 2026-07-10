import { createHash } from 'crypto';

export class SummonEnvelope {
  constructor(verb, args, meta = {}) {
    this.verb = verb;
    this.args = args;
    this.meta = meta;
    this.ts = new Date().toISOString();
    this.seal = this.#seal();
  }

  #seal() {
    const payload = JSON.stringify({ verb: this.verb, args: this.args, ts: this.ts });
    return createHash('sha256').update(payload).digest('hex');
  }

  toSexpr() {
    return `(${[this.verb, ...this.args].join(' ')})`;
  }

  toJSON() {
    return { verb: this.verb, args: this.args, sexpr: this.toSexpr(), seal: this.seal, ts: this.ts, ...this.meta };
  }
}

export const Envelope = {
  summon: (from, to, reason) =>
    new SummonEnvelope('summon', [from, to, `"${reason}"`], { from, to, type: 'summon' }),

  attach: (engine) =>
    new SummonEnvelope('attach', ['NEMOTRON', engine], { from: 'REXX', to: engine, type: 'attach' }),

  spawn: (profile) =>
    new SummonEnvelope('spawn', ['NEMOTRON', profile], { from: 'CARTO', to: 'NEMOTRON', type: 'spawn' }),

  seal: (receipt) =>
    new SummonEnvelope('seal', ['WORM', receipt], { from: 'CIPHER', to: 'WORM', type: 'seal' })
};
