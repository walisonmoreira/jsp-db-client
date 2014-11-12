create table student (
  id bigint not null,
  name varchar(50) not null,
  password varchar(50) not null,
  active varchar(3) not null,
  constraint pk_student primary key (id)
)