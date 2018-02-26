DROP DATABASE IF EXISTS kab;
CREATE DATABASE kab;
USE kab;

-- 用户状态表(用户表主键表)
DROP TABLE IF EXISTS `userStatus`;
CREATE TABLE `userStatus`(
	id INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(20) NOT NULL 		
)CHARSET=utf8;






INSERT INTO userStatus(`name`) VALUES('普通用户');
INSERT INTO userStatus(`name`) VALUES('讲师');
INSERT INTO userStatus(`name`) VALUES('培训师');
INSERT INTO userStatus(`name`) VALUES('高级培训师');
INSERT INTO userStatus(`name`) VALUES('管理员');






-- 用户表
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`(
	userCode VARCHAR(20) PRIMARY KEY,
	pwd VARCHAR(20) NOT NULL,
	email VARCHAR(20), 			-- 邮箱
	encryptedQuestion TEXT,			-- 密保问题
	encryptedAnswer TEXT,			-- 密保答案
	`status` INT NOT NULL 			-- 外键
)CHARSET=utf8;
ALTER TABLE `user` ADD CONSTRAINT FK_user 
FOREIGN KEY(`status`) REFERENCES userStatus(id);






INSERT INTO `user` VALUES('001','000000','xxx@qq.com','问题','答案',1);
INSERT INTO `user` VALUES('002','000000','xxx@qq.com','问题','答案',2);
INSERT INTO `user` VALUES('003','000000','xxx@qq.com','问题','答案',3);
INSERT INTO `user` VALUES('004','000000','xxx@qq.com','问题','答案',4);
INSERT INTO `user` VALUES('005','000000','xxx@qq.com','问题','答案',5);






-- 学历表(会员表主键表)
DROP TABLE IF EXISTS education;
CREATE TABLE education(
	id INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(20)
)CHARSET=utf8;



INSERT INTO education(`name`) VALUES('大专');
INSERT INTO education(`name`) VALUES('本科');
INSERT INTO education(`name`) VALUES('硕士');
INSERT INTO education(`name`) VALUES('博士');






-- 学校表(会员表主键表)
DROP TABLE IF EXISTS school;
CREATE TABLE school(
	id INT PRIMARY KEY AUTO_INCREMENT,
	city VARCHAR(20) NOT NULL,
	`name` VARCHAR(20)
)CHARSET=utf8;




INSERT INTO school(city,`name`) VALUES('深圳','深圳大学');
INSERT INTO school(city,`name`) VALUES('北京','北京大学');
INSERT INTO school(city,`name`) VALUES('北京','北京科技大学');





-- 会员表
DROP TABLE IF EXISTS member;
CREATE TABLE member(
	id INT PRIMARY KEY AUTO_INCREMENT,
	userCode VARCHAR(20) NOT NULL,		-- 用户编号，外键
	`name` VARCHAR(20) NOT NULL,		-- 真实姓名
	teachTime INT,				-- 任教时间，单位为年
	birthday DATE,				-- 生日
	education INT,				-- 学历，外键
	identityCard VARCHAR(18),		-- 身份证
	telePhone VARCHAR(20),			-- 手机号
	fixationPhone VARCHAR(20),		-- 固定电话
	address VARCHAR(255)			-- 通讯地址
)CHARSET=utf8;
ALTER TABLE member ADD CONSTRAINT FK_member_userCode
FOREIGN KEY(userCode) REFERENCES `user`(userCode);
ALTER TABLE member ADD CONSTRAINT FK_member_education
FOREIGN KEY(education) REFERENCES education(id);




INSERT INTO member(userCode,`name`,teachTime,birthday,education,identityCard,telephone,fixationPhone,address)
VALUES('002','呵呵',5,'1988-01-01',3,'111111111111111111','11111111111','010-1111111','深圳');
INSERT INTO member(userCode,`name`,teachTime,birthday,education,identityCard,telephone,fixationPhone,address)
VALUES('003','哈哈',8,'1986-01-01',3,'222222222222222222','22222222222','010-2222222','深圳');
INSERT INTO member(userCode,`name`,teachTime,birthday,education,identityCard,telephone,fixationPhone,address)
VALUES('004','嘿嘿',11,'1982-01-01',4,'333333333333333333','33333333333','010-3333333','北京');





-- 班级表
DROP TABLE IF EXISTS class;
CREATE TABLE class(
	id INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(20) NOT NULL,		-- 培训班名字
	teacherId INT NOT NULL,			-- 教师外键
	school INT NOT NULL,			-- 学校外键
	`type` VARCHAR(20) NOT NULL,		-- 班级类型
	`status` VARCHAR(20) NOT NULL, 		-- 班级状态
	createTime DATE NOT NULL 		-- 开班时间
)CHARSET=utf8;
ALTER TABLE class ADD CONSTRAINT FK_class_teacher
FOREIGN KEY(teacherId) REFERENCES member(id);
ALTER TABLE class ADD CONSTRAINT FK_school
FOREIGN KEY(school) REFERENCES school(id);




INSERT INTO class(`name`,teacherId,school,`type`,`status`,createTime) 
VALUES('培训1',1,1,'学生班','待开班','2018-3-3');
INSERT INTO class(`name`,teacherId,school,`type`,`status`,createTime) 
VALUES('培训2',2,1,'培训师班','已开班','2018-2-2');
INSERT INTO class(`name`,teacherId,school,`type`,`status`,createTime) 
VALUES('培训3',3,3,'高级培训师班','待开班','2018-3-1');




-- 年级表(学生表主键表)
DROP TABLE IF EXISTS grade;
CREATE TABLE grade(
	id INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(20)
)CHARSET=utf8;





INSERT INTO grade(`name`) VALUES('大一');
INSERT INTO grade(`name`) VALUES('大二');
INSERT INTO grade(`name`) VALUES('大三');
INSERT INTO grade(`name`) VALUES('研一');
INSERT INTO grade(`name`) VALUES('研二');
INSERT INTO grade(`name`) VALUES('其他');





-- 学生表
DROP TABLE IF EXISTS student;
CREATE TABLE student(
	studentNo VARCHAR(20) PRIMARY KEY,
	`name` VARCHAR(20) NOT NULL,		
	gender CHAR(2) NOT NULL,
	age INT NOT NULL,
	major VARCHAR(50),			-- 专业
	gradeId INT NOT NULL 			-- 年级外键
)CHARSET=utf8;
ALTER TABLE student ADD CONSTRAINT FK_grade
FOREIGN KEY(gradeId) REFERENCES grade(id);



INSERT INTO student
VALUES('s001','刘一波','男',19,'混凝土方块体移动师',1);
INSERT INTO student
VALUES('s002','刘二波','男',23,'混凝土方块体移动师',5);
INSERT INTO student
VALUES('s003','刘三波','女',20,'混凝土方块体移动师',6);




-- 概况表
DROP TABLE IF EXISTS survey;
CREATE TABLE survey(
	id INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(60) NOT NULL,
	author VARCHAR(20) NOT NULL,
	content TEXT NOT NULL
)CHARSET=utf8;




INSERT INTO survey(title,author,content) VALUES('KAB概况','admin','项目背景
    青年就业问题是当前世界各国共同面临的挑战。据联合国统计，目前全世界年龄处于15至24岁之间的青年人口超过11亿，是历史上青年人口最多的时期，其中85 %的青年生活在发展中国家。
    我国是青年人口大国。青年就业日益成为我国面临的重要就业问题之一。当前，我国劳动力市场上的求职人员中，75％左右是35岁以下的青年。近年来，由于高校招生规模扩大，高校毕业生人数迅猛增长，从2001年的117万人增长到2010年的630多万人。就业成为包括大学毕业生在内的广大青年最现实、最迫切的需求。
    创业是解决青年就业问题的重要途径。全球创业观察（由美国百森商学院、英国伦敦商学院和多家知名学术机构共同完成，调查覆盖全球35个国家，其经济总量占全球经济总量的92%）显示，无论是在发达国家还是在发展中国家，青年都是最具创业活力和创业潜力的群体。
    党和政府高度重视青年就业和创业问题。党的十七大报告提出，要实施扩大就业的发展战略，促进以创业带动就业。胡锦涛总书记要求广大青年要勇于艰苦创业，一定要焕发创业热情和创业活力，在改革开放和社会主义现代化建设中建功立业。
    项目简介
    为适应创新创造的时代要求，满足青年就业的现实需要，培养青年的创业意识和创业能力，共青团中央、全国青联与国际劳工组织合作，自2005年8月起在中国大学中开展KAB创业教育（中国）项目（简称“KAB项目”）。这是共青团中央、全国青联通过国际合作推进中国创业教育发展的一项尝试，旨在吸收借鉴国际经验的基础上，探索出一条具有中国特色的创业教育之路。
    KAB创业教育项目目前已在全球30多个国家开展。其核心内容是国际劳工组织为培养大中学生的创业意识和创业能力而专门开发的课程体系，与已经在各国广泛实施的“创办和改善你的企业”项目（SIYB项目）共同构成一个完整的创业培训体系。该课程一般以选修课的形式在大学开展，学生通过选修该课程可以获得相应的学分。围绕该课程，学生还可以参加KAB创业俱乐部、创业大讲堂等课外实践活动。通过教授和操练有关企业和创业的基本知识和技能，该项目帮助学生对创业树立全面认识和体验，切实提高其创业意识和创业能力，培养有创业和创新精神的青年人才。
    截至2011年2月，KAB创业教育（中国）项目已培训来自850所高校的2931名师资，在100所高校创设大学生KAB创业俱乐部，20万多名大学生参加了学习实践。在清华大学、中国青年政治学院、浙江大学等600多所高校开设了《大学生KAB创业基础》课程，公开出版了《大学生KAB创业基础》教师用书和学生用书两套教材，建立了课程建设、师资培训、质量控制、交流推广四大体系，受到师生广泛欢迎。根据教育的需要和学生的要求, 该项目将继续在全国各高校推广。
    推广计划
    2008年5月，经团中央书记处批准，为KAB项目的交流和推广，并为KAB相关合作机构提供服务与支持，中国青年报社负责组建KAB全国推广办公室。根据授权，KAB全国推广办公室主要职责如下： KAB项目的市场宣传与推广。在各大高校举办相关活动，引导更多高校加入KAB项目；为KAB项目筹款。为KAB项目的推广与发展募集资金；承办KAB项目相关会议。包括KAB创业教育论坛、KAB项目中国年会、KAB大讲堂等相关活动的承办与市场开发。负责KAB创业俱乐部的申请、联系等日常管理工作。为KAB相关合作机构提供服务与支持。包括为KAB日常管理机构、KAB中国研究所、KAB项目师资培训基地等机构提供相关协助、服务与支持，成为促进KAB事业的纽带。
    KAB全国推广办公室为更好的协调社会力量参加KAB项目，与中国光华科技基金会达成战略合作协议，在中国光华科技基金会设立“青年创业专项基金KAB项目”。专项负责筹集的KAB资金管理。
    根据KAB俱乐部发展要求，未来三年中，每年计划拓展100家KAB创业俱乐部。这将保证这一公益项目的可持续发展，加快培养高校师资，让广大高校大学生受益。
    为积极落实“以创业带动就业”的十七大精神，从创业教育入手，让有创业梦想的大学生对创业有一个相对完整的理解，在真正创业前做好各种准备，甚至提前尝试创业体验，提高大学生的创业成功率和抗风险能力。团中央、全国青联、全国学联、国际劳工组织将联合主办一系列活动，这些活动将主要由KAB全国推广办公室、中国光华科技基金会、KAB创业教育中国研究所等机构联合承办，目的是更好的推进KAB创业教育课程与实践的结合，使更多的高校开展KAB创业教育和成立KAB创业俱乐部，从而推动中国高校创业教育的发展，培养高校大学生的创新精神和创业能力。
    KAB主要活动
    1、“KAB年会”活动。该活动是KAB中国项目的重要活动之一，是为了总结KAB项目一年的成果，表彰一批先进的KAB师资和院校，并对KAB创业教育项目面临的问题进行研讨。该活动由团中央、全国青联、全国学联、国际劳工组织联合主办，由KAB全国推广办公室、中国青年报社及各高校承办。“KAB年会”活动每年举办一次。
    2、“KAB大讲堂”活动。主要是邀请一些知名企业家走进校园，讲述他们的创业成功经历，并和大学生进行互动交流。该活动由团中央、全国青联、全国学联、国际劳工组织联合主办，KAB全国推广办公室、中国青年报社等单位承办。该计划每年在全国高校举办25次到35次。
    3、“全国十佳KAB创业俱乐部”展示活动。该活动主要是为了指导、推动各高校开展KAB创业教育课外实践活动，帮助各高校大学生KAB创业俱乐部更好的发展。“全国十佳KAB创业俱乐部”展示活动由团中央、全国青联、全国学联、国际劳工组织联合主办，KAB全国推广办公室、中国青年报社、中国光华科技基金会等单位承办，活动从2008年起每年举办一次。
    4、“KAB创业俱乐部主席暑期训练营”活动。这个活动已经举办两届，由KAB全国推广办公室主办，中国光华科技基金会、诺基亚（中国）投资有限公司提供公益支持。这个活动主要为了提高俱乐部主席的领导管理能力，以及加强他们的实践能力。
    5、“创业计划书”展示活动。每年举办一次，该活动由团中央、全国青联、全国学联、国际劳工组织联合主办，由KAB全国推广办公室、中国青年报社及各高校承办，主要为了提高大学生的创业精神、创新意识，提高他们的创业素质与创业能力。
    加入KAB推广计划
    作为一项旨在提高和培养大学生创业能力和创新精神的公益活动，KAB项目离不开社会各界的支持，我们欢迎有责任的企业和企业家加入KAB推广计划，加入方式主要有三种。
    1、成为大学生KAB创业指导老师。大学生的创业热情很高，也有一些创业实践活动，为更好地指导大学生创业，我们计划向有创业经验的企业家、管理专家，包括企业和各研究机构发出邀请，聘请他们担当创业指导老师，以创业教练的身份与大学生直接交流，指导大学生创业。参加该计划的企业家和专家，一年至少要有半天时间义务与大学生就创业问题进行交流。
    2、为大学生KAB学员提供实践机会。该计划旨在让大学生KAB学员结合书本知识经验，在真正创业前，有机会参加各类社会实践，提高大学生的就业能力和创新精神。我们欢迎各大中型企业加入该计划，加入该计划的企业每年至少要提供一次大学生实践实习机会，人数、地域不限。
    3、赞助KAB行动。KAB项目是一个公益组织，因此需要面向社会筹集资金，扶持大学生参加社会实践，通过举办一系列活动，促进KAB项目在高校的发展，活跃大学校园的创业文化和创新精神。我们欢迎有责任的企业赞助KAB推广计划。');





-- 公告状态表(公告表外键表)
DROP TABLE IF EXISTS noticeLevel;
CREATE TABLE noticeLevel(
	id INT PRIMARY KEY AUTO_INCREMENT,
	`name` VARCHAR(20) NOT NULL
)CHARSET=utf8;





INSERT INTO noticeLevel(`name`) VALUES('一般');
INSERT INTO noticeLevel(`name`) VALUES('紧急');
INSERT INTO noticeLevel(`name`) VALUES('非常紧急');





-- 公告表
DROP TABLE IF EXISTS notice;
CREATE TABLE notice(
	id INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(60) NOT NULL,
	author VARCHAR(20) NOT NULL,
	modifyTime DATE NOT NULL,
	`level` INT NOT NULL, 			-- 紧急级别，外键		
	content TEXT NOT NULL
)CHARSET=utf8;
ALTER TABLE notice ADD CONSTRAINT FK_notice
FOREIGN KEY(`level`) REFERENCES noticeLevel(id);





INSERT INTO notice(title,author,modifyTime,`level`,content) 
VALUES('关于申报2013年度“大学生KAB 创业教育基地”和“KAB创业教育讲师资格”的通知','admin','2017-7-7',3,'有关KAB项目高校：
    为掌握高校关于KAB创业教育项目的实施情况，进一步规范和推动KAB项目的发展，将于近期组织开展2013年度“大学生KAB创业教育基地”、“KAB创业教育讲师”资格的申请和审核工作。现就有关事项通知如下。
    一、“大学生KAB创业教育基地”的认证标准
    1．至少有2名参加过KAB项目师资培训班并取得结业证书的教师；
    2．将《大学生KAB创业基础》课程纳入学校公共选修课体系，每学期授课时间不少于32学时；
    3．采用小班授课形式，每班学生人数不超过35人；
    4．提供KAB培训大纲中要求的教学场地、设施及必要的教辅材料；
    5．在课程结束后，根据学校规定给予考试合格的学生相应学分；
    6．积极参与和配合测评中心的质量监督与效果评估工作。
    二、申报“大学生KAB创业教育基地”须提交的材料
    1．填写大学生KAB创业教育基地申请表（附件1下载）；
    2．KAB课程教学计划表；
    3．KAB开课教师参加师资培训班结业证书的复印件；
    4．KAB学员成绩单（附件2下载）；
    5．高校创业教育调查表（附件3下载）；
    6．KAB课程学生培训绩效评价分析（附件4下载）；
    7．KAB课程课堂全景照片（3到5张）。
    三、申报“KAB创业教育讲师资格”
    1．已授予KAB基地的学校，如申请新增的KAB讲师资格，需提交KAB教师师资培训班结业证书复印件、教务部门或学校对于教师开设KAB课程的证明（附件5下载）。
    2．新申报KAB基地的学校，请将KAB讲师资格申请材料与基地申报材料一并提交，请勿单独提交。
    四、有关事项
    1．请有关KAB高校在KAB课程结束后半个月内提交相关申请材料。
    2．材料电子版请发至电子信箱kaboffice@gmail.com，并在发件主题中注明申请的内容（基地或讲师资格）。纸质版材料需经学校KAB项目主管领导签字，并加盖学校（或部门）公章，邮寄至KAB全国推广办公室魏和平（地址：北京东直门海运仓2号中国青年报社院内，邮编100702）。
    3．KAB项目主管单位将组织专家对申请基地的学校开课情况进行抽查。
    4．欢迎有关高校围绕KAB创业教育与理论研究、KAB教学教改经典案例、大学生创业教育理论、创业教育实践（包含教学教改）、创业管理等主题提交相关论文，我们将编纂成册在明年举办的KAB年会期间发布。
    联系人：
    KAB全国推广办公室（魏和平 010—64098510）
    KAB创业教育（中国）研究所（刘帆 13810856978）
    注：可登录KAB官方网站www.kab.org.cn查询具体情况。
    团中央学校部
    2013年11月25日');

INSERT INTO notice(title,author,modifyTime,`level`,content) 
VALUES('KAB创业俱乐部杭州沙龙活动通知','admin','2017-6-6',2,'有关KAB项目高校：
    为掌握高校关于KAB创业教育项目的实施情况，进一步规范和推动KAB项目的发展，将于近期组织开展2013年度“大学生KAB创业教育基地”、“KAB创业教育讲师”资格的申请和审核工作。现就有关事项通知如下。
    一、“大学生KAB创业教育基地”的认证标准
    1．至少有2名参加过KAB项目师资培训班并取得结业证书的教师；
    2．将《大学生KAB创业基础》课程纳入学校公共选修课体系，每学期授课时间不少于32学时；
    3．采用小班授课形式，每班学生人数不超过35人；
    4．提供KAB培训大纲中要求的教学场地、设施及必要的教辅材料；
    5．在课程结束后，根据学校规定给予考试合格的学生相应学分；
    6．积极参与和配合测评中心的质量监督与效果评估工作。
    二、申报“大学生KAB创业教育基地”须提交的材料
    1．填写大学生KAB创业教育基地申请表（附件1下载）；
    2．KAB课程教学计划表；
    3．KAB开课教师参加师资培训班结业证书的复印件；
    4．KAB学员成绩单（附件2下载）；
    5．高校创业教育调查表（附件3下载）；
    6．KAB课程学生培训绩效评价分析（附件4下载）；
    7．KAB课程课堂全景照片（3到5张）。
    三、申报“KAB创业教育讲师资格”
    1．已授予KAB基地的学校，如申请新增的KAB讲师资格，需提交KAB教师师资培训班结业证书复印件、教务部门或学校对于教师开设KAB课程的证明（附件5下载）。
    2．新申报KAB基地的学校，请将KAB讲师资格申请材料与基地申报材料一并提交，请勿单独提交。
    四、有关事项
    1．请有关KAB高校在KAB课程结束后半个月内提交相关申请材料。
    2．材料电子版请发至电子信箱kaboffice@gmail.com，并在发件主题中注明申请的内容（基地或讲师资格）。纸质版材料需经学校KAB项目主管领导签字，并加盖学校（或部门）公章，邮寄至KAB全国推广办公室魏和平（地址：北京东直门海运仓2号中国青年报社院内，邮编100702）。
    3．KAB项目主管单位将组织专家对申请基地的学校开课情况进行抽查。
    4．欢迎有关高校围绕KAB创业教育与理论研究、KAB教学教改经典案例、大学生创业教育理论、创业教育实践（包含教学教改）、创业管理等主题提交相关论文，我们将编纂成册在明年举办的KAB年会期间发布。
    联系人：
    KAB全国推广办公室（魏和平 010—64098510）
    KAB创业教育（中国）研究所（刘帆 13810856978）
    注：可登录KAB官方网站www.kab.org.cn查询具体情况。
    团中央学校部
    2013年11月25日');

INSERT INTO notice(title,author,modifyTime,`level`,content) 
VALUES('第三届青年恒好大学生创意编织作品展示活动通知','admin','2017-9-9',1,'有关KAB项目高校：
    为掌握高校关于KAB创业教育项目的实施情况，进一步规范和推动KAB项目的发展，将于近期组织开展2013年度“大学生KAB创业教育基地”、“KAB创业教育讲师”资格的申请和审核工作。现就有关事项通知如下。
    一、“大学生KAB创业教育基地”的认证标准
    1．至少有2名参加过KAB项目师资培训班并取得结业证书的教师；
    2．将《大学生KAB创业基础》课程纳入学校公共选修课体系，每学期授课时间不少于32学时；
    3．采用小班授课形式，每班学生人数不超过35人；
    4．提供KAB培训大纲中要求的教学场地、设施及必要的教辅材料；
    5．在课程结束后，根据学校规定给予考试合格的学生相应学分；
    6．积极参与和配合测评中心的质量监督与效果评估工作。
    二、申报“大学生KAB创业教育基地”须提交的材料
    1．填写大学生KAB创业教育基地申请表（附件1下载）；
    2．KAB课程教学计划表；
    3．KAB开课教师参加师资培训班结业证书的复印件；
    4．KAB学员成绩单（附件2下载）；
    5．高校创业教育调查表（附件3下载）；
    6．KAB课程学生培训绩效评价分析（附件4下载）；
    7．KAB课程课堂全景照片（3到5张）。
    三、申报“KAB创业教育讲师资格”
    1．已授予KAB基地的学校，如申请新增的KAB讲师资格，需提交KAB教师师资培训班结业证书复印件、教务部门或学校对于教师开设KAB课程的证明（附件5下载）。
    2．新申报KAB基地的学校，请将KAB讲师资格申请材料与基地申报材料一并提交，请勿单独提交。
    四、有关事项
    1．请有关KAB高校在KAB课程结束后半个月内提交相关申请材料。
    2．材料电子版请发至电子信箱kaboffice@gmail.com，并在发件主题中注明申请的内容（基地或讲师资格）。纸质版材料需经学校KAB项目主管领导签字，并加盖学校（或部门）公章，邮寄至KAB全国推广办公室魏和平（地址：北京东直门海运仓2号中国青年报社院内，邮编100702）。
    3．KAB项目主管单位将组织专家对申请基地的学校开课情况进行抽查。
    4．欢迎有关高校围绕KAB创业教育与理论研究、KAB教学教改经典案例、大学生创业教育理论、创业教育实践（包含教学教改）、创业管理等主题提交相关论文，我们将编纂成册在明年举办的KAB年会期间发布。
    联系人：
    KAB全国推广办公室（魏和平 010—64098510）
    KAB创业教育（中国）研究所（刘帆 13810856978）
    注：可登录KAB官方网站www.kab.org.cn查询具体情况。
    团中央学校部
    2013年11月25日');
    
    
    
    
    



-- 资讯表
DROP TABLE IF EXISTS information;
CREATE TABLE information(
	id INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(60) NOT NULL,
	author VARCHAR(20) NOT NULL,
	modifyTime DATE NOT NULL,
	recommend INT NOT NULL,				-- 是否推荐，1为推荐
	content TEXT NOT NULL
)CHARSET=utf8;





INSERT INTO information(title,author,modifyTime,recommend,content) VALUES('新商业合伙人峰会举行','admin','2017-5-5',1,'本报讯 在美国好莱坞用红外线扫描蜘蛛侠的模型，下一分钟，在中国杭州的家中就能用3D打印机“拷贝”出一模一样的模型……这些不是科幻片中的情景，已经悄悄地在浙江人的日常生活中实现。12月28日，由浙江省商务厅、共青团浙江省委共同指导，浙江在线、浙江省电子商务促进会联合主办，浙江在线浙江电商网承办的“2013首届新商业合伙人峰会”上，10个用科技改变传统商贸及现代服务业的本土创新项目团队获得了2013年度优秀新商业合伙人团队称号。活动吸引了500多名省内外来自电商、互联网、媒体以及投资界的资深人士到场。

　　峰会上围绕“大数据时代的新商业模式”易观国际资深分析师的主题演讲为传统商贸企业转型开拓了新的思路。著名投资人李治国、斯凯CEO宋涛以及十个优秀创新团队创始人现身说法，分享了团队合作在创业创新中的重要性。荣获优秀商业创新荣誉的团队中也不乏明星项目，如致力于传统企业电商转型的熙浪科技、用信息匹配解决打车难的“快的”等。');

INSERT INTO information(title,author,modifyTime,recommend,content) VALUES('温州：底线思维防范企业','admin','2017-8-6',0,'本报讯 在美国好莱坞用红外线扫描蜘蛛侠的模型，下一分钟，在中国杭州的家中就能用3D打印机“拷贝”出一模一样的模型……这些不是科幻片中的情景，已经悄悄地在浙江人的日常生活中实现。12月28日，由浙江省商务厅、共青团浙江省委共同指导，浙江在线、浙江省电子商务促进会联合主办，浙江在线浙江电商网承办的“2013首届新商业合伙人峰会”上，10个用科技改变传统商贸及现代服务业的本土创新项目团队获得了2013年度优秀新商业合伙人团队称号。活动吸引了500多名省内外来自电商、互联网、媒体以及投资界的资深人士到场。

　　峰会上围绕“大数据时代的新商业模式”易观国际资深分析师的主题演讲为传统商贸企业转型开拓了新的思路。著名投资人李治国、斯凯CEO宋涛以及十个优秀创新团队创始人现身说法，分享了团队合作在创业创新中的重要性。荣获优秀商业创新荣誉的团队中也不乏明星项目，如致力于传统企业电商转型的熙浪科技、用信息匹配解决打车难的“快的”等。');

INSERT INTO information(title,author,modifyTime,recommend,content) VALUES('企业登记拿证快','admin','2017-3-2',1,'本报讯 在美国好莱坞用红外线扫描蜘蛛侠的模型，下一分钟，在中国杭州的家中就能用3D打印机“拷贝”出一模一样的模型……这些不是科幻片中的情景，已经悄悄地在浙江人的日常生活中实现。12月28日，由浙江省商务厅、共青团浙江省委共同指导，浙江在线、浙江省电子商务促进会联合主办，浙江在线浙江电商网承办的“2013首届新商业合伙人峰会”上，10个用科技改变传统商贸及现代服务业的本土创新项目团队获得了2013年度优秀新商业合伙人团队称号。活动吸引了500多名省内外来自电商、互联网、媒体以及投资界的资深人士到场。

　　峰会上围绕“大数据时代的新商业模式”易观国际资深分析师的主题演讲为传统商贸企业转型开拓了新的思路。著名投资人李治国、斯凯CEO宋涛以及十个优秀创新团队创始人现身说法，分享了团队合作在创业创新中的重要性。荣获优秀商业创新荣誉的团队中也不乏明星项目，如致力于传统企业电商转型的熙浪科技、用信息匹配解决打车难的“快的”等。');






-- 新闻表
DROP TABLE IF EXISTS news;
CREATE TABLE news(
	id INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(60) NOT NULL,
	author VARCHAR(20) NOT NULL,
	modifyTime DATE NOT NULL,
	recommend INT NOT NULL,				-- 是否推荐，1为推荐
	content TEXT NOT NULL
)CHARSET=utf8;





INSERT INTO news(title,author,modifyTime,recommend,content) VALUES('第三届“青年恒好”创意编织作品展示活动北服校园宣讲会','admin','2018-1-1',1,' 四川美术学院的姚蓓蓓多次参加“青年恒好”活动，并屡次得奖。今年11月27日，由姚蓓蓓负责的织梦编织吧终于在四川美术学院落地，这让她非常兴奋。“织毛衣、织围巾已经不像我小时候那么热门，可实际上古老的编织技艺是创作艺术品的手段，通过编织成画等艺术加工，就能够将几十元的毛线变成价值上千元、上万元的艺术品。”她告诉记者，“这正是国际上流行的‘纤维艺术’，我希望能把纤维艺术带入中国。”
    像姚蓓蓓一样，通过“青年恒好”活动实现创业梦想的大学生越来越多。12月18日，由KAB全国推广办公室、恒源祥（集团）有限公司主办的第三届“青年恒好”成果发布会在北京召开。本届活动以“中国梦”为主题，除了对公益创业项目、校园编织吧创业计划书进行征集，还对大学生创意编织进行展示，同时资助公益创业项目及校园编织吧，引导大学生树立公益创业意识，扶持资助大学生创业实践活动。
    主办方介绍说，第三届“青年恒好”活动于今年3月26日启动，其中的大学生公益创业方案征集活动共吸引了100多所高校团队参加，经过遴选和评审，山西大学、北京邮电大学等10个团队的公益创业方案被评为“十佳公益项目”，10个团队分别获得3000元的项目扶持资金，“十佳编织吧项目”同期出炉。8月28日，“十佳编织吧项目”代表在北京进行了项目展示，经过10多位专家评审，最终来自四川美术学院、佳木斯大学等高校的“七强”编织吧项目各获得一期创业资金1.5万元。
    今年，除了四川美术学院之外，“青年恒好”织梦编织吧还分别在云南林业职业技术学院和佳木斯大学落地，3支编织吧团队分别再次获得4.5万元的落地资金，活动主办方为每个编织吧项目配备了两名创业指导老师扶持创业团队真正创业。即将上线的“织梦商城”，还将为今后所有落地的校园编织吧提供网上销售渠道，为编织吧创业团队提供全方位多层次的经营管理培训与品牌经营辅导。佳木斯大学编织吧负责人华衷寒表示，她原来只是有一个构想，没想到通过“青年恒好”活动最终把梦想变成现实。
 
    本报记者 陶涛 《 中国青年报 》（ 2013年12月23日 09 版）');

INSERT INTO news(title,author,modifyTime,recommend,content) VALUES('2013年KAB俱乐部主席暑期训练营在北京开营','admin','2018-1-1',1,' 四川美术学院的姚蓓蓓多次参加“青年恒好”活动，并屡次得奖。今年11月27日，由姚蓓蓓负责的织梦编织吧终于在四川美术学院落地，这让她非常兴奋。“织毛衣、织围巾已经不像我小时候那么热门，可实际上古老的编织技艺是创作艺术品的手段，通过编织成画等艺术加工，就能够将几十元的毛线变成价值上千元、上万元的艺术品。”她告诉记者，“这正是国际上流行的‘纤维艺术’，我希望能把纤维艺术带入中国。”
    像姚蓓蓓一样，通过“青年恒好”活动实现创业梦想的大学生越来越多。12月18日，由KAB全国推广办公室、恒源祥（集团）有限公司主办的第三届“青年恒好”成果发布会在北京召开。本届活动以“中国梦”为主题，除了对公益创业项目、校园编织吧创业计划书进行征集，还对大学生创意编织进行展示，同时资助公益创业项目及校园编织吧，引导大学生树立公益创业意识，扶持资助大学生创业实践活动。
    主办方介绍说，第三届“青年恒好”活动于今年3月26日启动，其中的大学生公益创业方案征集活动共吸引了100多所高校团队参加，经过遴选和评审，山西大学、北京邮电大学等10个团队的公益创业方案被评为“十佳公益项目”，10个团队分别获得3000元的项目扶持资金，“十佳编织吧项目”同期出炉。8月28日，“十佳编织吧项目”代表在北京进行了项目展示，经过10多位专家评审，最终来自四川美术学院、佳木斯大学等高校的“七强”编织吧项目各获得一期创业资金1.5万元。
    今年，除了四川美术学院之外，“青年恒好”织梦编织吧还分别在云南林业职业技术学院和佳木斯大学落地，3支编织吧团队分别再次获得4.5万元的落地资金，活动主办方为每个编织吧项目配备了两名创业指导老师扶持创业团队真正创业。即将上线的“织梦商城”，还将为今后所有落地的校园编织吧提供网上销售渠道，为编织吧创业团队提供全方位多层次的经营管理培训与品牌经营辅导。佳木斯大学编织吧负责人华衷寒表示，她原来只是有一个构想，没想到通过“青年恒好”活动最终把梦想变成现实。
 
    本报记者 陶涛 《 中国青年报 》（ 2013年12月23日 09 版）');

INSERT INTO news(title,author,modifyTime,recommend,content) VALUES('KAB创业俱乐部杭州沙龙活动','admin','2018-1-1',0,' 四川美术学院的姚蓓蓓多次参加“青年恒好”活动，并屡次得奖。今年11月27日，由姚蓓蓓负责的织梦编织吧终于在四川美术学院落地，这让她非常兴奋。“织毛衣、织围巾已经不像我小时候那么热门，可实际上古老的编织技艺是创作艺术品的手段，通过编织成画等艺术加工，就能够将几十元的毛线变成价值上千元、上万元的艺术品。”她告诉记者，“这正是国际上流行的‘纤维艺术’，我希望能把纤维艺术带入中国。”
    像姚蓓蓓一样，通过“青年恒好”活动实现创业梦想的大学生越来越多。12月18日，由KAB全国推广办公室、恒源祥（集团）有限公司主办的第三届“青年恒好”成果发布会在北京召开。本届活动以“中国梦”为主题，除了对公益创业项目、校园编织吧创业计划书进行征集，还对大学生创意编织进行展示，同时资助公益创业项目及校园编织吧，引导大学生树立公益创业意识，扶持资助大学生创业实践活动。
    主办方介绍说，第三届“青年恒好”活动于今年3月26日启动，其中的大学生公益创业方案征集活动共吸引了100多所高校团队参加，经过遴选和评审，山西大学、北京邮电大学等10个团队的公益创业方案被评为“十佳公益项目”，10个团队分别获得3000元的项目扶持资金，“十佳编织吧项目”同期出炉。8月28日，“十佳编织吧项目”代表在北京进行了项目展示，经过10多位专家评审，最终来自四川美术学院、佳木斯大学等高校的“七强”编织吧项目各获得一期创业资金1.5万元。
    今年，除了四川美术学院之外，“青年恒好”织梦编织吧还分别在云南林业职业技术学院和佳木斯大学落地，3支编织吧团队分别再次获得4.5万元的落地资金，活动主办方为每个编织吧项目配备了两名创业指导老师扶持创业团队真正创业。即将上线的“织梦商城”，还将为今后所有落地的校园编织吧提供网上销售渠道，为编织吧创业团队提供全方位多层次的经营管理培训与品牌经营辅导。佳木斯大学编织吧负责人华衷寒表示，她原来只是有一个构想，没想到通过“青年恒好”活动最终把梦想变成现实。
 
    本报记者 陶涛 《 中国青年报 》（ 2013年12月23日 09 版）');





-- 新闻评论表
DROP TABLE IF EXISTS newsComment;
CREATE TABLE newsComment(
	id INT PRIMARY KEY AUTO_INCREMENT,
	newsId INT NOT NULL,
	modifyTime DATE NOT NULL,
	content TEXT NOT NULL
)CHARSET=utf8;
ALTER TABLE newsComment ADD CONSTRAINT FK_news
FOREIGN KEY(newsId) REFERENCES news(id);






INSERT INTO newsComment(newsId,modifyTime,content) VALUES(1,NOW(),'震惊！！！');
INSERT INTO newsComment(newsId,modifyTime,content) VALUES(1,NOW(),'震惊+1！！！');
INSERT INTO newsComment(newsId,modifyTime,content) VALUES(2,NOW(),'哈哈哈哈或或或或或或');






-- 课程表
DROP TABLE IF EXISTS course;
CREATE TABLE course(
	id INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(60) NOT NULL,
	author VARCHAR(20) NOT NULL,
	modifyTime DATE NOT NULL,
	recommend INT NOT NULL,				-- 是否推荐，1为推荐
	content TEXT NOT NULL
)CHARSET=utf8;





INSERT INTO course(title,author,modifyTime,recommend,content) VALUES('大学生创业的必然性','KAB教育网','2018-2-2',1,'最近，大学生创业备受社会各界关注，尤其是今年中共十八大报告中明确提出，推动实现更高质量的就业，引导劳动者转变就业观念，鼓励多渠道、多形式就业，促进创业带动就业，加强职业技能的培训，提升劳动者就业创业能力，增强就业稳定性等。KAB全国推广办公室总干事张坤说，这给我们提出了下一步明确的工作目标和发展方向，作为国内高校中率先系统性推广创业教育的项目，KAB是目前国内覆盖高校最广、师资最多的创业教育项目，引导、扶持大学生就业创业义不容辞。 
课程介绍：  
课程讲师：李素 
报名电话：010-32*8812
讲师介绍：
北京大学经济型讲师');
INSERT INTO course(title,author,modifyTime,recommend,content) VALUES('面试技巧','KAB教育网','2018-2-2',1,'最近，大学生创业备受社会各界关注，尤其是今年中共十八大报告中明确提出，推动实现更高质量的就业，引导劳动者转变就业观念，鼓励多渠道、多形式就业，促进创业带动就业，加强职业技能的培训，提升劳动者就业创业能力，增强就业稳定性等。KAB全国推广办公室总干事张坤说，这给我们提出了下一步明确的工作目标和发展方向，作为国内高校中率先系统性推广创业教育的项目，KAB是目前国内覆盖高校最广、师资最多的创业教育项目，引导、扶持大学生就业创业义不容辞。 
课程介绍：  
课程讲师：李素 
报名电话：010-32*8812
讲师介绍：
北京大学经济型讲师');
INSERT INTO course(title,author,modifyTime,recommend,content) VALUES('创业实战','KAB教育网','2018-2-2',0,'最近，大学生创业备受社会各界关注，尤其是今年中共十八大报告中明确提出，推动实现更高质量的就业，引导劳动者转变就业观念，鼓励多渠道、多形式就业，促进创业带动就业，加强职业技能的培训，提升劳动者就业创业能力，增强就业稳定性等。KAB全国推广办公室总干事张坤说，这给我们提出了下一步明确的工作目标和发展方向，作为国内高校中率先系统性推广创业教育的项目，KAB是目前国内覆盖高校最广、师资最多的创业教育项目，引导、扶持大学生就业创业义不容辞。 
课程介绍：  
课程讲师：李素 
报名电话：010-32*8812
讲师介绍：
北京大学经济型讲师');








-- 关于我们
DROP TABLE IF EXISTS about;
CREATE TABLE about(
	id INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(60) NOT NULL,
	content TEXT NOT NULL
)CHARSET=utf8;





INSERT INTO about(title,content) VALUES('关于我们','企业支持KAB（中国）项目的所有合作，均由KAB全国推广办公室具体协商实现。KAB全国推广办公室设在中国青年报社。
    中国光华科技基金会是本项目战略合作单位，所有赞助经费均可作为慈善款项，由基金会开具合法有效的善款专用免税发票。
    KAB项目资源
    国际品牌：KAB已由国际劳工组织在全球30多个国家成功推广，国际知名度高，影响力大。
    政府资源：KAB（中国）项目由共青团中央、全国青联、全国学联、国际劳工组织共同主办，得到各相关政府部门的大力支持。
    高校资源：KAB（中国）项目作为高校创业教育的重大突破，获得各地高校的大力支持和积极参与。目前有850多所高校参与该项目。
    创业俱乐部：KAB（中国）项目在每个项目高校都支持建立一家大学生KAB创业俱乐部，由KAB师资指导有兴趣和潜力参与创业的大学生组成，是各高校最活跃、最具创造性和执行力的校园社团之一。目前在全国100所高校有创业俱乐部。
    媒体资源：KAB全国推广办公室设在中国青年报社。《中国青年报》是中国最有公信力和影响力的主流媒体之一，将全力参与KAB（中国）项目的各项推广工作。中国青年报旗下《青年参考》、《青年商旅报》、《青年时讯》、中青在线、中国校媒网等媒体也将深度参与KAB的推广工作。
    中国高校传媒联盟：中国高校传媒联盟是由中国青年报社发起成立，理事单位包括北京大学、清华大学、南开大学、复旦大学等230家高校，吸纳了2000多家校园媒体会员，能最直接、最深入地完成校园覆盖。
    KAB项目合作价
    全球公益品牌——成功的国际公益品牌项目来到中国 KAB创业教育项目是已经在全球30多个国家成功开展的国际性公益项目，在全球范围具有广泛的知名度，是国际劳工组织倾力打造的公益品牌项目。为了满足大学生发展和创业的迫切需要，贯彻中共十七大提出的“以创业带动就业”的总体要求，共青团中央、全国青联、全国学联与国际劳工组织合作，在中国大力推动KAB项目。
    多方共赢项目——学校、企业、学生多方共赢的推广模式 KAB官方引进的公益教育项目，对学校而言，将获得相关的资源和政策，迅速创办并实施学校的创业教育，极大地提升学生的创业意识和能力；对企业而言，参与公益项目是企业承担社会责任的重要表现，同时也是企业深入高校校园市场的机会；而大学生在KAB项目中，不仅可以学到创业知识，开阔眼界，还能得到实战训练。
    高校全面覆盖——中国高校传媒联盟全面参与 在KAB推广过程中，中国高校传媒联盟将全面参与其中，旗下校报、校刊、校园电台、校园电视台、校园网、校园BBS等所有校园媒体都将成为KAB校园推广的前沿阵地。中国高校传媒联盟理事单位覆盖230多所高校。
    顶级媒体推广——最有影响力、公信力的主流媒体鼎力宣传 KAB全国推广办公室设在中国青年报社。中国青年报社利用自身媒体资源全力宣传推广KAB项目的同时，将发挥作为团中央机关报和全国性主流媒体的特殊地位，联合《人民日报》、《光明日报》、《经济日报》、新华社、中央人民广播电台、中央电视台、中国教育电视台、新浪、搜狐、网易、腾讯等多种形态的全国主流媒体和各地方主流媒体，共同参与KAB项目在全国的宣传报道。');





-- 版权声明
DROP TABLE IF EXISTS copyright;
CREATE TABLE copyright(
	id INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(60) NOT NULL,
	content TEXT NOT NULL
)CHARSET=utf8;





INSERT INTO copyright(title,content) 
VALUES('版权声明','本网站的所有内容，包括但不限于文字，图标，商标，标识，按钮，图像，
声音片段，数据以及软件等，当网站注册用户在论坛，博客，微波以及其他应用下载粘贴，
商城发布的其他形式之知识产权，均与我们相关权方单独或共同享有。
并受著作权和其他相关法律 法规的保护，未经我们或相关部门的准许，不能转载，使用，复制，
发行本哇工作的内容。');






-- 人才招聘
DROP TABLE IF EXISTS talents;
CREATE TABLE talents(
	id INT PRIMARY KEY AUTO_INCREMENT,
	job VARCHAR(50) NOT NULL,		-- 需求岗位
	number INT NOT NULL,			-- 需求人数
	demand VARCHAR(255),			-- 岗位要求
	pay VARCHAR(20) 			-- 薪资
)CHARSET=utf8;




INSERT INTO talents(job,number,demand,pay) VALUES('java软件工程师',2,'','面议');
INSERT INTO talents(job,number,demand,pay) VALUES('.net软件开发工程师',1,'','面议');
INSERT INTO talents(job,number,demand,pay) VALUES('网站编辑',1,'','面议');





-- 联系我们
DROP TABLE IF EXISTS relation;
CREATE TABLE relation(
	id INT PRIMARY KEY AUTO_INCREMENT,
	address VARCHAR(255) NOT NULL,
	phone VARCHAR(20) NOT NULL,
	way VARCHAR(255) NOT NULL 		-- 乘车方式
)CHARSET=utf8;




INSERT INTO relation(address,phone,way) 
VALUES('北京海淀区成府路201号','010-12122221','地铁4号线，北京大学东门站B口出200米');





