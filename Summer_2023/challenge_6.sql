-- SQL request(s) below
SELECT * 
FROM onlineChat oc JOIN studentsChatsMap scm on oc.CHATID = scm.CHATID
WHERE oc.CREATEDAT between '3961-05-05' and '3961-05-12';

SELECT * 
FROM STUDENT s
WHERE s.AVGGRADE > (select avg(s2.AVGGRADE) from student s2);

SELECT rah.STUDENTID
FROM  room r JOIN roomAccessHistory rah ON r.ROOMID = rah.ROOMID
WHERE r.ROOMNAME = 'Chemistry supply room'
ORDER BY (rah.EXITEDAT - rah.ENTEREDAT) DESC
limit 1;

SELECT classID
FROM Class
WHERE NOT EXISTS (
    SELECT 1
    FROM schedule
    WHERE classID = Class.classID
    AND hour = 15
);