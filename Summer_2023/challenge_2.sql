SELECT a.name, count(*)
FROM mutant m join agent a on m.RECRUITERID = a.AGENTID
group by a.name
order by count(8) desc
limit 10