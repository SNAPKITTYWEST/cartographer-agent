/* REXX GLUE KERNEL
   Purpose: docket routing, records glue, notice automation */

parse upper arg caseId action target .

if caseId = '' then do
  say 'REXX GLUE KERNEL ONLINE'
  say 'USAGE: rexx rexx-glue-kernel.rexx <CASE_ID> <ACTION> <TARGET>'
  say 'ACTIONS: ROUTE_NOTICE ROUTE_LEDGER BUILD_PACKET'
  exit 1
end

if action = '' then action = 'ROUTE_NOTICE'
if target = '' then target = 'DOCKET_QUEUE'

select
  when action = 'ROUTE_NOTICE' then do
    say 'CASE='caseId
    say 'ACTION=ROUTE_NOTICE'
    say 'TARGET='target
    say 'STATUS=NOTICE ROUTED TO WORKFLOW QUEUE'
  end
  when action = 'ROUTE_LEDGER' then do
    say 'CASE='caseId
    say 'ACTION=ROUTE_LEDGER'
    say 'TARGET='target
    say 'STATUS=LEDGER ROUTED TO RECORDS CHANNEL'
  end
  when action = 'BUILD_PACKET' then do
    say 'CASE='caseId
    say 'ACTION=BUILD_PACKET'
    say 'TARGET='target
    say 'STATUS=PACKET BUILD REQUEST EMITTED'
  end
  otherwise do
    say 'CASE='caseId
    say 'ACTION='action
    say 'TARGET='target
    say 'STATUS=UNKNOWN ACTION'
    exit 2
  end
end

exit 0
