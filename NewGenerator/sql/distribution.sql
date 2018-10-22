use distributiondb;

create table Customer(
  cuID varchar(20) primary key ,
  customerName varchar(20),
  customerPsd varchar(20),
  customerSex char(10),
  Birthday datetime,
  Tel varchar(20),
  Address varchar(50),
  Comment varchar(100)
);
insert into Customer values	('123456','陈卓越','zy123','男','1999-5-20','13977512345','南方IT学院','无'),
  ('123457','卓悦','Dz123','男','1999-5-21','13977512346','南方IT学院1','无'),
  ('123458','Zy','Dz123','男','1999-5-22','13977512347','南方IT学院2','无');
create table Province(
  provinceID varchar(20) primary key ,
  provinceName varchar(20)
);
insert into Province values	
  ('10010','广东'),
  ('10001','上海'),
  ('10086','北京');
create table City(
  cityID varchar(20) primary key ,
  provinceID varchar(20) references Province(provinceID),
  cityName varchar(20),
  provinceName varchar(20)
);
insert into City values	('6666','10010','珠海','广东'),
  ('6667','10010','深圳','广东'),
  ('6668','10086','河源','广东'),
create table Route(
  routeID varchar(20) primary key,
  cityID varchar(20) references City(cityID),
  provinceID varchar(20) references Province(provinceID),
  routeName varchar(20),
  startProvice varchar(20),
  startCity varchar(20),
  endProvince varchar(20),
  endCity varchar(20),
  midProvince varchar(20),
  midCity varchar(20),
  transportPrice decimal(20),
  Comment varchar(100)
);
insert into Route values
  ('1111','6666','10010','路线一','广东','珠海','广西','玉林','广东','东莞',100,'无'),
  ('1112','6667','10010','路线二','广东','深圳','广西','玉林','广东','东莞',120,'无'),
  ('1113','6669','10086','路线三','广西','玉林','广东','珠海','广西','玉林',100,'无');
create table Car(
  carID varchar(20) primary key,
  routeID varchar(20) references Route(routeID),
  carType varchar(20),
  carOrgin varchar(50),
  carProDate datetime,
  carBuyDate datetime,
  carCapacity int,
  carstate bit,
  Comment varchar(100)
);
insert into Car values	
  ('004','1114','吉利','河源','2011-11-13','2011-11-13',1,1,'无'),
  ('001','1111','吉普','玉林','2011-11-11','2011-11-11',1,1,'无'),
  ('002','1112','三轮','南宁','2011-11-12','2011-11-12',1,1,'无'),
  ('003','1113','北京现代','深圳','2011-11-13','2011-11-13',1,1,'无');

create table Orders(
  orderID varchar(20) primary key,
  carID varchar(20) references Car(carID),
  cuID varchar(20) references Customer(cuID),
  postPName varchar(20) ,
  postPTel varchar(20),
  postPAddr varchar(50),
  getPName varchar(20),
  getPTel varchar(20),
  getPAddr varchar(50),
  goodsName varchar(100),
  goodsWeight int,
  orderType varchar(10),
  orderState varchar(20),
  transportPrice decimal(20),
  deliveryPrice decimal(20),
  totalPrice varchar(20),
  Comment varchar(100)
);
insert into Orders values 	
('001','001','123456','陈卓悦','13977512345','南方IT学院','DZ','13977512344','女装山脉','脉动',12,'无','送出',100,100,'100','无'),
('002','002','123458','Zy','13977512347','南方IT学院','张东明','13977512344','女装山脉','脉动',12,'无','送出',100,100,'100','无'),
('003','003','123456','陈卓悦','13977512345','南方IT学院','DZ','13977512344','女装山脉','脉动',12,'无','送出',100,100,'100','无');
create table DeliveryReceipt(
  deliveryReceliptID varchar(20) primary key,
  startCity varchar(20),
  endCity varchar(20),
  midCity varchar(20),
  makeDate datetime,
  State varchar(20),
  Comment varchar(100)
);

insert into DeliveryReceipt values 	
('001','珠海','玉林','东莞','2018-10-21','state1','无'),
  ('002','玉玲','珠海','东莞','2018-10-21','state1','无'),
  ('003','珠海','玉林','东莞','2018-10-21','state2','无');
create table Association_1(
  orderID varchar(20) references Orders(orderID),
  deliveryReceliptID varchar(20) references DeliveryReceipt(deliveryReceliptID),
  primary key(orderID,deliveryReceliptID)
);
insert into Association_1 values('001','001'),
  ('002','002'),
  ('003','003');
create table Role (
  roleID varchar(20) primary key ,
  roleName varchar(20),
  Comment varchar(100)
);
insert into Role values	('001','role1','无'),
('002','role2','无'),
('003','role3','无');
create table Manager(
  mqID varchar(20) primary key,
  roleID varchar(20) references Role(roleID),
  managerName varchar(20),
  managerPsd varchar(20),
  managerSex char(10),
  Tel varchar(20),
  Address varchar(50),
  Comment varchar(100)
);
insert into Manager values	('001','001','张东明','123456','男','15212345678','南方IT学院','无'),
  ('002','002','东明','123456','男','15212345679','南方IT学院1','无'),
  ('003','003','Dz','111111','男','15212345670','南方IT学院2','无');

create table DeliveryPlace(
  dePID varchar(20) primary key,
  mgID varchar(20) references Manager(mgID),
  dePName varchar(20),
  provinceName varchar(20),
  cityName varchar(20),
  mgName varchar(20),
  dePTel varchar(20),
  dePAddr varchar(20),
  Comment varchar(100)
);
insert into DeliveryPlace values('001','001','南方it学院','广东','珠海','张东明','15212345678','南方IT学院','无'),
  ('002','002','南方it学院2','广西','玉林','东明','15212345679','南方IT学院2','无'),
  ('003','003','南方it学院3','广东','珠海','Dz','15212345670','南方IT学院3','无');

create table DeliveryRange(
  rangeID varchar(20) primary key,
  dePID varchar(20) references DeliveryPlace(dePID),
  areaID varchar(20) references CityArea(areaID),
  rangeName varchar(20),
  deliveryPrice decimal(20),
  Comment varchar(100)
);
insert into DeliveryRange values('001','001','001','交付范围1',100,'无'),
  ('002','002','002','交付范围2',120,'无'),
  ('003','003','003','交付范围3',140,'无');
create table CityArea(
  areaID varchar(20) primary key ,
  cityID varchar(20) references City(cityID),
  rangeID varchar(20) references DeliveryRange(rangeID),
  areaName varchar(20),
  cityName varchar(20)
);
insert into CityArea values	('001','6666','001','区域1','珠海'),
  ('002','6667','002','区域2','珠海'),
  ('003','6668','003','区域3','珠海');

