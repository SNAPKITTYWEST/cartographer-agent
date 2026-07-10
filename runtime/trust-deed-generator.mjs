import { createHash } from 'crypto';

function sealPayload(payload) {
  return createHash('sha256').update(JSON.stringify(payload)).digest('hex');
}

export function generateTrustDeed({
  deedId,
  deedClass,
  trustee,
  beneficiary,
  powers = [],
  restrictions = [],
  authority = 'active',
  issuedBy = 'CARTO'
}) {
  const issuedAt = new Date().toISOString();
  const payload = {
    deed_id: deedId,
    deed_class: deedClass,
    trustee,
    beneficiary,
    powers,
    restrictions,
    authority,
    issued_by: issuedBy,
    issued_at: issuedAt
  };

  return {
    ...payload,
    seal: sealPayload(payload)
  };
}
