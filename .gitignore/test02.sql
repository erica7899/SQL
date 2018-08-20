/*DDL은 rollback이 안된다.commit은 가능하다.
 * DML은 rollback이 가능하다.  commit해야 확정을 한다.*/

/*테이블 생성*/
drop table book;/*테이블 삭제 명령*/

create table book(
	bookno number(5), /*정수5자리의 bookno 생성*/
	title varchar2(50),/*문자열 50자리의 title 생성*/
	author varchar(10),
	pubdate date/*현재 날짜를 알려주는 date 생성*/
);/*create는 취소가 불가능하다.그리고 이렇게 만든 table은 중복된 데이터도 그대로 다 나타난다.*/


rollback;/*이전 명령 취소. 하지만 이미 만들어지 ㄴcreate table은 취소가 되지 않는다.*/
commit;
desc book; /*book table의 구조를 보여준다.*/
select * from book order by bookno;

/*테이블에 데이터 등록*/
insert into book values(1,'java','홍길동','12/02/02');/*열 별로 넣는다*/
insert into book values(1,'java','홍길동','12/02/02');
insert into book values(2,'sql','고길동','17/12/02');
insert into book values(3,'database','최길동','18/02/12');
insert into book values(4,'spring','박길동','18/07/02');

truncate table book;

/*commit다음은 rollback 안됨. commit은 다른 곳에서 수정한 table을 다른 곳에서도 바뀌게 한는 것.*/

/*DDL명령어
create table 테이블 생성
alter table 테이블 관련 변경 alter table book add(pubs varchar2(50));
rename 이름 변경
truncate 테이블의 모든 데이터 삭제
drop table 테이블 삭제
comment */

/*위에있는 book table을 지우고 다시 생성*/
create table book(
	bookno number(5) CONSTRAINT PK_book primary key,/*중복되는걸 방지하기 위해 primary key 설정.null허용 안함*/
	isbn varchar2(10) CONSTRAINT unique_book_isbn unique, /*중복이 안됨. null은 허용*/
	title varchar2(50),/*문자열 50자리의 title 생성*/
	author varchar(10),
	price number(5) check(price>0),/*가격에 음수가 들어가는걸 방지*/
	pubdate date default sysdate/*아무것도 입력하지 않으면 현재 시간정보를 넣는다.*/
)
insert into book values(4,'111-111','spring','박길동',700,'18/07/02');
insert into book values(1,'111-222','spring','박길동',700,'18/07/02');
insert into book values(2,null,'spring','박길동',700,'18/07/02');
insert into book values(3,'111-333','spring','박길동',700,'18/07/02');
insert into book (bookno,title,price) values (5,'java',1990);
insert into book values(4,'spring','박길동',-9700,'18/07/02');/*가격에 음수 데이터가 들어가는걸 혀용한다.*/

delete from book where bookno=4; /*auto commit이 지워짐*/

update book set title = 'database';/*모든 title data가 바뀐다.*/

update book set title = 'data' where bookno=1;
/*primary key는 다른 col보다 search속도가 빠르다.*/
/*cmd와 함께 진행할 땐 cmd에서 commit를 해야한다.*/


select * from emp;

drop table book cascade constraint;/*다른곳에서 참조하고 있으면 테이블을 지울 수 없다. 강제로 지울수는 있다.*/


select * from emp where deptno=30;
create table emp30 as select * from emp where deptno=30;
select * from emp30;

/*view
 * */
select e.name 사원명, m.ename 매니저이름, d.dname 부서명
from emp e , emp m, dept d
where e.mrg=m.empno and e.deptno=d.deptno;/*이걸 간단히만들고 싶을 때*/

create or replace view emp_dept 
as
select e.ename 사원명, m.ename 매니저이름, d.dname 부서명
from emp e , emp m, dept d
where e.mgr=m.empno and e.deptno=d.deptno;

select * from emp_dept;/*간단히 만들었지만 수정은 안된다.*/


/*sequence:자동번호 생성기. unique한 번호를 생성하고자 할 때. 별도의 concurrency,performance의 고려를 할 필요 없음
 * oracle에서만 사용가능.*/
create sequence seq_bookno
start with 1 increment by 1 cache 20;
/*1부터 시작해서 1씩 증가하고 20개를 생성해줘*/

select seq_bookno.nextval from dual;/*dual:dummy table/ nextval할때마다 1씩 증가.*/
select seq_bookno.currval from dual;/*현재 시퀀스의 값 확인*/
drop seq_bookno;/*시퀀스 지우기*/


insert into book values(seq_bookno.nextval,null,'spring','박길동',700,'18/07/02');
/*primary key가 저절로 1씩 증가하면서 중복되지 않고 입력이 된다.*/








