select rownum,ename,sal
from EMP order by sal desc;

select rownum,ename,sal
from(select * from emp order by sal desc);
/*rownum:numbering*/

/*급여 순서에서 상위 3개 뽑기*/
select rownum,ename,sal
from(select * from emp order by sal desc)
where rownum<4;
