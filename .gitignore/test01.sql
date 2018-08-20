select * from emp;
select * from dept;
select * from SALGRADE;

//1.사원 이름, 사원 매니저 이름, 사원 근무 부서 출력
select e.name 사원명, m.ename 매니저이름, d.dname 부서명
from emp e , emp m, dept d
where e.mrg=m.empno and e.deptno=d.deptno;

//2.emp 테이블의 급여 정보를 기반으로 salgrade 등급을 표시하기
select e.ename 사원명, e.sal 급여정보 , s.grade 등급
from emp e, salgrade s
where e.sla between s.losal and s.hisal;



//집계함수:여러행으로부터 하나의 결과값을 반환
//AVG,COUNT(NULL도 포함),MAX,MIN,SUM
select ename,sal from emp;
select avg(sal) from emp;
select round(avg(sal),2) from emp;

select job from emp;
select count(job) from emp;
select count(distinct job) from emp;

select sal, deptno from emp order by deptno;



select emp.dento, sum(sal) 총급여, round(avg(sal),2) 평균급여, min(sal) 최소급여,
max(sal) 최대급여, count(sal) 인원수
from emp
group by deptno; //deptno에 같은 데이터끼리 묶는다.

select emp.deptno, dname, sum(sal) 총급여, round(avg(sal),2) 평균급여, min(sal) 최소급여,
max(sal) 최대급여, count(sal) 인원수
from emp,dept
where emp.deptno=dept.deptno
group by emp.deptno,dname
order by deptno

/*평균 급여가 2500 이상인 부서 정보 출력*/
select emp.deptno,dname,round(avg(sal),2) 평균급여
from emp,dept
where emp.deptno=dept.deptno /*집계함수는 where에 쓸 수 없다.*/
group by emp.deptno,dname
having  round(avg(sal),2)>2500 /*having에 써야한다.*/
order by deptno


select avg(sal) from emp;
select round(avg(sal),2) from emp;
/*select max(avg(sal)) from emp;->error
 * round는 단일행 함수. max는 집계함수. avg는 단일행 함수이기 때문에 단일행 함수에 쓰면 오류가 나지 않지만
 * 집계함수에 쓰면 오류가 난다.
 */
select max(avg(sal)) from emp group by deptno;
/*평균 급여를 가장많이 받는 부서 정보가 찍힌다.
 * select deptno,max(avg(sal)) from emp group by deptno;->error
 * 부서 이름을 찍고싶지만 에러가 난다.
 * select deptno, avg(sal) from emp group by deptno는 가능.
 * max는 집계함수고 avg는 단일행 함수이기 때문에 가능하다.
 */

/*where은group by  앞에 와야한다.
select에는 group by 에 있는 애만 사용가능 하기 때문에 써줘야함.
순서:select-from-where-group by-order by*/

select deptno,job,count(*)
from emp
group by deptno,job
order by deptno;

/* *은 null을 포함해서 센다. */

/*select deptno, avg(sal) from emp;
이건 에러가 난다. */
/*순서:from-where-grop by - having-order by -select*/

/*서브쿼리문
 * 사원 중 ford보다 급여가 많은 사원 목록
 */
select * from emp where ename='FORD'/*FORD급여가 얼마인지 확인*/
select * from emp where sal>3000
select * from emp where sal>(select sal from emp where ename='FORD')
/*서브쿼리문
 * 괄호안에 select * from emp where ename='FORD'를 넣으면 에러가 난다. *은 전체 col을 나타내기 때문이다. 어떤 값인지 정확히 표시를 해주어야 한다.
 * 괄호 안에는 단일행이 와야한다. 만약 결과값이 여러 행이 된다면 누구랑 비교할지 모르기 때문에 에러가 난다.*/

/*급여가 2000이상인 부서별 사원수*/
select deptno,count(*)
from emp
where sal>=2000
group by deptno;

/*job이 'clerk'가 아닌 사원의 부서별 급여 한계가 6500 이상인 부서 리스트*/
select deptno,sum(sal),count(*)
from emp
where job <>'CLERK'/*<>:제외하고*/
group by deptno
having sum(sal)>6500
  
select ename,sal,deptno,job
from emp
where ename in (select min(ename) from emp group by deptno )/*서브쿼리문은 3명을 뽑는데 =은 1개의 데이터ㅡㄹ 받아야 하기 떄문에 오류가 난다.*/
/*group by 하면 집ㄱㅖ함수가 잇어야 한다.*/
/*in은 여러개 데이터를 처리. =대신 사용*/
 
 /*부서별 가장 작은 급여를 받는 사원 목록*/
  
 select  deptno,ename,sal
 from emp
 where sal in (select min(sal) from emp group by deptno);
 
 /*평균 급여가 가장 높은 부서 정보*/
 select deptno,avg(sal)
 from emp
 group by deptno
 having avg(sal)= (select  max(avg(sal)) from emp group by deptno)
 
 /*전체 평균보다 급여가 많은 사람, 자신이 속한 부서의 평균 급여보다 작은 사람*/
 select ename, sal, deptno
 from emp o
 where sal>(select avg(sal) from emp where deptno=o.deptno)
 
 select rownum,empno,ename,sal
 from emp
 order by sal
