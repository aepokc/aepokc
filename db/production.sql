DROP TABLE IF EXISTS admins;
CREATE TABLE admins (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, email varchar(255) DEFAULT '' NOT NULL, encrypted_password varchar(128) DEFAULT '' NOT NULL, password_salt varchar(255) DEFAULT '' NOT NULL, reset_password_token varchar(255), remember_token varchar(255), remember_created_at datetime, sign_in_count integer DEFAULT 0, current_sign_in_at datetime, last_sign_in_at datetime, current_sign_in_ip varchar(255), last_sign_in_ip varchar(255), created_at datetime, updated_at datetime);
INSERT INTO admins VALUES(1,'admin@aepokc.com','$2a$10$adGiKeqx4f3XvDATJlyHPOhlyWXNllF49Ia/2gUlzYk0NxuP3F2hy','$2a$10$adGiKeqx4f3XvDATJlyHPO',NULL,NULL,NULL,14,'2010-08-16 01:49:51.491152','2010-08-15 21:17:36.028584','127.0.0.1','127.0.0.1','2010-08-14 23:18:25.686441','2010-08-16 01:49:51.492018');
DROP TABLE IF EXISTS events;
CREATE TABLE events (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, member_id integer, title varchar(255), date date, time varchar(255), details text, sanctioned boolean, created_at datetime, updated_at datetime);
DROP TABLE IF EXISTS jobs;
CREATE TABLE jobs (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, member_id integer, title varchar(255), employer varchar(255), link varchar(255), time varchar(255), location varchar(255), industry varchar(255), experience varchar(255), education varchar(255), salary integer, description text, email varchar(255), phone integer, created_at datetime, updated_at datetime);
DROP TABLE IF EXISTS members;
CREATE TABLE members (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, email varchar(255) DEFAULT '' NOT NULL, encrypted_password varchar(128) DEFAULT '' NOT NULL, password_salt varchar(255) DEFAULT '' NOT NULL, reset_password_token varchar(255), remember_token varchar(255), remember_created_at datetime, sign_in_count integer DEFAULT 0, current_sign_in_at datetime, last_sign_in_at datetime, current_sign_in_ip varchar(255), last_sign_in_ip varchar(255), confirmation_token varchar(255), confirmed_at datetime, confirmation_sent_at datetime, firstname varchar(255), lastname varchar(255), leader boolean, created_at datetime, updated_at datetime);
DROP TABLE IF EXISTS membership_applications;
CREATE TABLE membership_applications (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, firstname varchar(255), lastname varchar(255), email varchar(255), address varchar(255), city varchar(255), state varchar(255), zip varchar(255), phone varchar(255), company varchar(255), title varchar(255), associations text, interests text, first varchar(255), second varchar(255), third varchar(255), agreement boolean, created_at datetime, updated_at datetime);
DROP TABLE IF EXISTS pages;
CREATE TABLE pages (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, title varchar(255), link varchar(255), content text, position integer, parent_id integer, created_at datetime, updated_at datetime);
INSERT INTO pages VALUES(1,'About Us','about','<div class="font12" style="color: #157f1f;"><b>lead by example - champion a 
	cause - cultivate a passion</b></div>
<br />
Welcome to the Alliance of Emerging Professionals website - a hub of activity 
and networking that exists to enhance your life as an Oklahoma City young 
professional. We are Oklahoma City''s premier young professionals organization 
and we are excited about our growth and your interest in becoming an aep member. 
We are seeking young leaders who wish to increase their professional, civic and 
social networks and make OKC an excellent place to work and live. Please explore 
the website and be sure to check our events calendar to learn more about how you 
can get involved immediately.
<br />
<br />
The Alliance of Emerging Professionals (aep) is a dynamic organization of young 
people who share a passion to experience the best of Oklahoma City and the goal 
of creating a diverse and vibrant community with a superb quality of life. 
Founded in 2004 by half a dozen men and women in their mid-twenties, aep is now 
an organization with strong leadership, dedicated committees and a growing 
membership.
<br />
<br />
The sole focus and driving passion of aep is to impact change in Oklahoma City''s 
cultural and professional landscapes. We believe young professionals can be 
influential leaders and make a positive impact on the future of our city through 
community outreach and networking. We are the voice of the next generation of 
leaders. We bring together newcomers and locals, traditionalists and 
trendsetters, entrepreneurs and corporate - the best and brightest of OKC. aep 
is the best forum for young professionals to meet each other, experience the 
city, learn what''s going on and make a difference for tomorrow.',1,NULL,'2010-08-16 01:51:52.554818','2010-08-16 01:56:07.693534');
INSERT INTO pages VALUES(2,'Membership','membership','The objective of aep is to network young professionals, provide volunteer opportunities, and influence the community through our collective voice.
Regular social events facilitate the exploration of what Oklahoma City has to offer, civic and service projects help us give back and make our community a better place, and meetings with civic and government leaders keeps us informed and allow us to make our voices heard. 
aep''s members enjoy benefits (both tangible and intangible) that allow for increased exposure and involvement in the community, increasing their potential for professional development and leadership in various aspects of the community.',2,NULL,'2010-08-16 01:54:44.608924','2010-08-16 01:54:44.608924');
INSERT INTO pages VALUES(3,'Resources','resources','aep hosts a number of civic, social and professional events throughout the year in Oklahoma City. 
Our social mixers have been held at the newest attractions in the city and continue to be a great place to meet new people. 
Our civic projects have included Habitat for Humanity, Big Brothers Big Sisters, food shelters and White Fields - a new local boys home. 
Our professional business meetings give aep members and guests insight into OKC''s business and political leadership. 
Through our partnership with the Chamber, aep speaks at colleges throughout the state, job fairs, Greater Grads events and other Chamber functions. 
aep-sponsored leadership retreats are held in some the best venues in Oklahoma and are a great way to learn more about other new aep members. 
Check the events calendar and the resources pages for the next big adventure!',3,NULL,'2010-08-16 01:57:34.015390','2010-08-16 01:57:34.015390');
INSERT INTO pages VALUES(4,'Partners','partners','***REVISION NEEDED***<br />
<br />
aep''s partners provide voluntary in-kind and monetary support to aep and allow the organization to sustain itself and grow at a faster rate.  
Our partners are all corporate citizens that actively support the community and provide valuable services to the community.  
Many of these partners are the foundation for our employment directory and cooperatively work with the Chamber and aep to recruit and retain professional talent.
<br />
<br />
We sincerely thank our partners and encourage our members to support these businesses and organizations.',4,NULL,'2010-08-16 01:58:44.960964','2010-08-16 02:15:09.076399');
INSERT INTO pages VALUES(5,'Contact','contact','aep is a virtual corporation that exists through a network of Members and Supporters.  
The Greater Oklahoma City Chamber provides invaluable support with aep''s daily operations and strategic direction. 
We welcome your questions and comments.
<br />
<br />
<b>Alliance of Emerging Professionals</b>
<br />
PO Box 1784
<br />
Oklahoma City, OK 73101-1784
<br />
<br />
<a href="mailto:info@aepokc.com">info@aepokc.com</a>',5,NULL,'2010-08-16 02:00:17.019736','2010-08-16 02:00:17.019736');
INSERT INTO pages VALUES(6,'Home','','Please click the Home tab above to return to the main page.',6,NULL,'2010-08-16 02:01:11.635417','2010-08-16 02:01:11.635417');
INSERT INTO pages VALUES(7,'OKC Chamber','chamber','<a href="http://www.okcchamber.com"><img src="/images/chamber.gif" width="250" heigh="125" style="float: right; margin: 0 0 10px 15px;" alt="" /></a>

The Chamber is the voice of business and a visionary organization in Oklahoma 
City. It has more than 4,500 members and recently won the ACCE (American Chamber 
of Commerce Executive) Award of Excellence as "the nation''s best" Chamber of 
Commerce. The Chamber''s focus is on economic development, legislation and 
education/workforce development.<br /><br />

The Chamber believes in aep''s mission statement and has created a mutual and 
beneficial partnership to engage, retain and recruit young professionals in OKC.<br /><br />

The Chamber''s Greater Grads Program is driven to retain Oklahoma''s college 
graduates. aep recognizes the importance of this program and will be 
instrumental in achieving the retention goal by utilizing member college 
connections, sponsoring networking events and job fairs and making personal 
visits to college campuses and events.<br /><br />

The Chamber is providing assistance to aep through administrative support, 
membership coordination and web site maintenance as part of the mutual agreement 
to help grow Oklahoma City''s pool of young professionals as well as its 
intellectual and cultural capital.',1,1,'2010-08-16 02:02:40.838281','2010-08-16 02:02:40.838281');
INSERT INTO pages VALUES(8,'Committees','committees','aep''s committees are the lifeblood of the organization and the cogs that keep 
our organization moving forward. Members are encouraged to join a committee to 
learn more about the organization and to foster development of new ideas and 
create the critical mass necessary for the organization to remain a leading edge 
contributor within the community.<br /><br />

<b>Social</b><br />

Chair - <a href="mailto:djames@sheratonokcity.com">Darian James</a><br /><br />

The primary responsibility of aep''s Social Committee is to manage aep''s monthly 
meetings - coordinating with speakers and venues to provide aep members with the 
best opportunities for networking and introduce them to Oklahoma City''s leaders 
as well as its arts and civic communities. This committee is also responsible 
for managing volunteer events including the annual Big Brothers Big Sisters 
Summer Event and many others.<br /><br />

<b>Membership</b><br />
Chair - <a href="mailto:Illuminateskin@myarbonne.com">Kristin Ellis</a><br /><br />

The Membership Committee is the backbone of the organization and is actively 
engaged in recruiting new members and managing and increasing member benefits. 
This committee is responsible for aep''s Ambassador Program and is responsible 
for campus visits as well as employer relations.<br /><br />

<b>Volunteer</b><br />
Chair - <a href="mailto:kistianescapa@kw.com">Kistian Escapa</a><br /><br />

aep''s members are actively involved in community outreach through existing 
charitable organizations. The Volunteer Committee coordinates these opportunites 
with nonprofit social welfare organizations and aep''s collective membership.<br /><br />

<b>Marketing</b><br />
Board Liaison - <a href="mailto:ashlie_cornelius@yahoo.com">Ashlie Cornelius</a><br /><br />

The creation of advertisements, press releases and overall branding is the 
Marketing Committee''s focus. This includes the distribution of collateral 
materials to prospective and current members as well as the creation of 
materials for the aep website and partner sites.<br /><br />

<b>Internal Affairs</b><br />
Chair - <a href="mailto:me@micahalcorn.com">Micah Alcorn</a><br /><br />

The Internal Affairs Committee manages many operational aspects of the 
organization. It was responsible for forming aep''s by-laws and for obtaining 
certification as a 501(c)(6) nonprofit organization. Additionally, this 
committee manages aep''s finance, budgeting and fundraising activities and drafts 
new policies that the membership and leadership agree upon.',2,1,'2010-08-16 02:03:33.318974','2010-08-16 02:03:33.318974');
INSERT INTO pages VALUES(9,'Board of Directors','board','<div style="float: left; width: 165px;"><img src="/images/team/acornelius.jpg" width="150" alt="" /></div>
<div style="float: left; width: 395px; text-align: justify;">
<b>Ashlie Cornelius</b><br />
Ashlie is an Assistant Director of Marketing at the University of Oklahoma in Norman. Some of her responsibilities include career fair management, branding the organization, creating advertisements, public relations, and managing social networking sites. Since joining OU, Ashlie has doubled employer attendance at several events, and has been featured as a guest blogger and also quoted on stories she has written on career advice. Ashlie earned a BA in Advertising from the University of Oklahoma, where she was a member of Alpha Omicron Pi. Prior to joining OU, she worked in the oil industry as a marketing coordinator. She is a member of the Oklahoma City Chamber, PRSA, OU Campus Communicators, the OU Alumni Association, and works with a state agency to help children with developmental disabilities. Ashlie enjoys running, playing tennis, and painting in her free time.</div>

<div class="clear"></div>
<div class="hr"></div>

<div style="float: left; width: 165px;"><img src="/images/team/ktorkelson.jpg" width="150" alt="" /></div>
<div style="float: left; width: 395px; text-align: justify;">
<b>Kristen Torkelson</b><br />
Kristen is an Environmental Specialist at Cardinal Engineering, Inc. She attended the University of Oklahoma in Norman, studied abroad in Spain for six months, and earned a BA in Spanish. She then went on to the OU Health Sciences Center to obtain her Masters in Public Health with an emphasis in Environmental Health. She was on the Operations Staff committee for the Big Event for four years during her undergraduate work, and was the Chair of the OUHSC Big Event for two years. She was also Secretary of the OUHSC Student Association, and the Community Service Chair for the College of Public Health Student Association. Kristen''s hobbies include running, rock climbing, being a gym rat, doing anything outdoors, traveling, and trying new things.</div>
<div class="clear"></div>
<div class="hr"></div>

<div style="float: left; width: 165px;"><img src="/images/team/dwilson.jpg" width="150" alt="" /></div>
<div style="float: left; width: 395px; text-align: justify;">
<b>Derek Wilson</b><br />
Derek currently works for Pension Solutions in Oklahoma City. At Pension Solutions, he works with Investment Advisors specifically helping them set up retirement plans for their corporate and nonprofit clients, including 401(k), 403(b), and 457(b) plans, as well as pension plans. Derek has received a certificate in Retirement Plan Fundamentals while working to achieve the designation of a Qualified Plan Financial Consultant from the American Society of Pension Actuaries. Obtaining this will not only provide him with a higher designation, it will also further his knowledge in the retirement plan industry. Derek graduated from the University of Oklahoma with a BBA in Finance, and since then has worked in the financial services industry. These companies include Morgan Stanley, BancFirst, and Wachovia Securities. Derek is the President of his Toastmasters club, enjoys playing golf, racquetball, and ice hockey.</div>

<div class="clear"></div>',3,1,'2010-08-16 02:04:32.854489','2010-08-16 02:04:32.854489');
INSERT INTO pages VALUES(10,'Leadership Team','leadership','<div style="float: left; width: 165px;"><img src="/images/team/malcorn.jpg" alt="" width="150" /></div>
<div style="float: left; width: 395px; text-align: justify;">
<b>Micah Alcorn</b><br />
Micah is the Managing Member of Royce Commercial Asset Management, a Norman commercial real estate firm that focuses on the ongoing operation of medical and general office buildings. 
Micah also conducts transaction brokerage as an Associate of Domain Commercial where he represents investors, developers, and occupants of all forms of commercial real estate in their procurement and negotiations.
Prior to this, he worked for nearly two years in consumer lending and has long shared a passion for startup companies and political action. He earned a BBA from the University of Oklahoma 
with double majors in Entrepreneurship/Venture Management and Economics.
</div>

<div class="clear"></div>
<div class="hr"></div>

<div style="float: left; width: 165px;"><img src="/images/team/kellis.jpg" alt="" width="150" /></div>
<div style="float: left; width: 395px; text-align: justify;">
<b>Kristin Ellis</b><br />
Kristin has worked at Barnes and Noble for the past several years and credits her position for letting her be more creative, which she loves.  
Excelling in customer service is a key point to her position as she creates a friendly, casual, and helpful experience.  
Kristin obtained a Bachelor''s Degree in Music Business from Belmont University in Nashville, TN.  
She was an intern at several major music labels before returning back to Oklahoma in 2007.  
Kristin has been a longtime volunteer for Presbyterian Hospital, and now volunteers at OU Medical Center.  
With an extreme love for makeup, Kristin also holds a side business as an Independent Consultant with Arbonne International.  
She enjoys reading, music, singing in her church choir, traveling, and being around friends and family.
</div>

<div class="clear"></div>
<div class="hr"></div>

<div style="float: left; width: 165px;"><img src="/images/team/kescapa.jpg" alt="" width="150" /></div>
<div style="float: left; width: 395px; text-align: justify;">
<b>Kistian Escapa</b><br />

Kistian has been a real estate agent with Keller Williams Northwest for several years.  
She works predominantly as a buyer''s agent not only in Oklahoma City but in areas as far as Blanchard to Guthrie.  
Another focus is assisting first time homebuyers in understanding all facets of the home purchasing process, namely educating them in how to obtain available down payment assistance.  
Kistian was a Public Relations major at the University of Central Oklahoma where she was a founding member of the Delta Zeta sorority serving as Social External Chair.  
Kistian''s passion is helping the community.  In addition to being the aep Volunteer Chair, she also volunteers with the Central Oklahoma Humane Society and is one of the Event Organizers for ProjectOKC.
</div>

<div class="clear"></div>
<div class="hr"></div>

<div style="float: left; width: 165px;"><img src="/images/team/djames.jpg" alt="" width="150" /></div>
<div style="float: left; width: 395px; text-align: justify;">
<b>Darian James</b><br />
Darian is the Director of Banquets and Events at The Sheraton Hotel in downtown Oklahoma City where he is responsible for booking, executing, and directing events.  
Before joining Sheraton OKC, Darian was the Banquet Manager at The Sheraton Tulsa.  
He is a two time Manager of the Year and Food and Beverage Employee of the Year.  
Darian graduated from Spartan College of Aeronautics in Tulsa where he resided for 5 years before moving to Oklahoma City.  
He is originally from St. Thomas, U.S. Virgin Islands, but has lived in Oklahoma City for the past 10 years.  
Darian also organizes social events for Miasha Orphanage in Oklahoma City.  
He enjoys volunteering with charitable organizations, running, rowing, dancing, and meeting new people.
</div>

<div class="clear"></div>
<div class="hr"></div>
<div style="float: left; width: 395px; text-align: left;" class="center"><br />
	Many opportunities are available for aep members with a passion for 
	leadership. <a href="mailto:info@aepokc.com">Contact</a> us today to learn 
	how you can become involved in the Leadership Team.
</div>',4,1,'2010-08-16 02:06:16.160835','2010-08-16 02:06:16.160835');
INSERT INTO pages VALUES(11,'In the News','news','<b>Groups seek to improve city, Tulsa</b> | <i>08/24/2007</i><br />
For decades, state and business leaders have been talking about reversing the 
trend of Oklahoma college graduates moving to other parts of the country. [<a href="/??????????.pdf" target="_blank">Full 
Article</a>]<br /><br />

<b>aep and Chamber Partner for Grads</b> | <i>08/24/2007</i><br />
The Alliance of Emerging Professionals (aep) and the Chamber have formed a 
partnership to address a common goal: keeping young professionals in Oklahoma 
City. [<a href="/??????????.pdf" target="_blank">Full Article</a>]<br /><br />

<b>Oklahomas Young Professionals: Looking For Superior Quality Of Life</b> | <i>
08/24/2007</i><br />

As the Baby Boomers exit the workforce in droves, every industry will feel the 
deficit. According to Angelou Economics and KMK Consulting, retaining human 
capital is the No. 1 issue facing businesses and communities. [<a href="/??????????.pdf" target="_blank">Full 
Article</a>]',5,1,'2010-08-16 02:08:29.923491','2010-08-16 02:08:29.923491');
INSERT INTO pages VALUES(12,'Criteria','criteria','As Oklahoma City''s premier young professionals organization, aep is seeking members who want to take an active role in the community, recruit new members and assist existing members by mentoring them in the early stages of their careers.  aep''s membership is growing and each member''s experience and background builds our diversity and network.<br /><br />

To become an aep member, you must:<br />

<ul>
<li>be 20-39 years of age</li>

<li>be gainfully employed or seeking employment &mdash; this includes interns and students</li>
<li>join one committee and participate in that committees activities &mdash; as your schedule permits</li>
<li>participate in business, social and civic meetings &mdash; as your schedule permits</li>
<li>pay annual dues of $20</li>
</ul>',1,2,'2010-08-16 02:09:46.155248','2010-08-16 02:09:46.155248');
INSERT INTO pages VALUES(13,'Benefits','benefits','Current members have exclusive benefits and privileges that include the following:<br />

<ul>
<li>Becoming involved in OKC</li>
<li>Expanding professional and social networks</li>
<li>Joining a committee of your choice and affecting change in the community</li>

<li>Inclusion in and access to aep''s online and print membership directory</li>
<li>Access to members only events and meetings</li>
<li>Discount pricing at social mixers and annual signature events</li>
</ul>

<div style="text-align: justify">

We strongly encourage our members to explain the benefits of joining our organization to their employers so that these employers may pay membership dues on your behalf.
</div>',2,2,'2010-08-16 02:10:21.230714','2010-08-16 02:10:21.230714');
INSERT INTO pages VALUES(14,'Application','application','This is a placeholder necessary to generate the left navigation link.',99,2,'2010-08-16 02:11:24.569169','2010-08-16 02:11:24.569169');
INSERT INTO pages VALUES(15,'Calendar','calendar','This is a placeholder necessary to generate the left navigation link.',1,3,'2010-08-16 02:12:14.719687','2010-08-16 02:12:14.719687');
INSERT INTO pages VALUES(16,'Events','events','This is a placeholder necessary to generate the left navigation link.',2,3,'2010-08-16 02:12:36.559603','2010-08-16 02:12:36.559603');
INSERT INTO pages VALUES(17,'Jobs','jobs','This is a placeholder necessary to generate the left navigation link.',3,3,'2010-08-16 02:12:58.315239','2010-08-16 02:12:58.315239');
INSERT INTO pages VALUES(18,'Nonprofits','nonprofits','***REVISION NEEDED***<br />
<br />
aep is proud to lend volunteer support to many existing charities in OKC. Here is a list of those, and how you can get involved, etc, blah, blah...',1,4,'2010-08-16 02:17:15.968473','2010-08-16 02:17:15.968473');
INSERT INTO pages VALUES(19,'Sponsors','sponsors','***REVISION NEEDED***<br />
<br />
aep is bootstrapped, and in constant need of CA$H!!! If you are interested in making a contribution, please contact us so that we can complete this section...',2,4,'2010-08-16 02:18:54.804472','2010-08-16 02:18:54.804472');
DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL, member_id integer, avatar_file_name varchar(255), avatar_content_type varchar(255), avatar_file_size integer, avatar_updated_at datetime, phone integer, email varchar(255), hometown varchar(255), college varchar(255), degree varchar(255), occupation varchar(255), interests text, status varchar(255), fname varchar(255), tname varchar(255), lname varchar(255), created_at datetime, updated_at datetime);
DROP TABLE IF EXISTS schema_migrations;
CREATE TABLE schema_migrations (version varchar(255) NOT NULL);
INSERT INTO schema_migrations VALUES('1');
INSERT INTO schema_migrations VALUES('2');
INSERT INTO schema_migrations VALUES('3');
INSERT INTO schema_migrations VALUES('4');
INSERT INTO schema_migrations VALUES('5');
INSERT INTO schema_migrations VALUES('6');
INSERT INTO schema_migrations VALUES('7');
CREATE UNIQUE INDEX index_admins_on_email ON admins (email);
CREATE UNIQUE INDEX index_admins_on_reset_password_token ON admins (reset_password_token);
CREATE UNIQUE INDEX index_members_on_email ON members (email);
CREATE UNIQUE INDEX index_members_on_reset_password_token ON members (reset_password_token);
CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations (version);
