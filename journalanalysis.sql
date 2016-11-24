.read journaldata.sql
.read journalpotentials.sql

select "---------------------------------";
select "TABLE 2:";
select "  # of Papers that Use Evolve for Each Journal";
select "  # of Relevant Papers for Each Journal";
select "";

create table helper2a as --Counts Relevant Items
    select journal, count(*) as relevant, category from journals group by journal;
create table helper2b1 as --Counts Yes to Evolve
    select journal, count(*) as yescount from journals where lower(evolve) = "yes" group by journal;
create table helper2b2 as --Lists all Items with yescount = null if 0 Yes to Evolve
    select journals.journal as journal, yescount from journals left join helper2b1 on helper2b1.journal=journals.journal group by journals.journal;
create table helper2b3 as --Replace all null values with 0
    select journal, ifnull(yescount,0) as yescount from helper2b2;
create table table2 as
    select "[" || a.category || "] " || a.journal || ": " || round(cast(b.yescount as float)/a.relevant*100,1) || "% (" || b.yescount || "/" || a.relevant || ")" from helper2a as a, helper2b3 as b where a.journal = b.journal order by a.category;
select * from table2;

select "";
select "---------------------------------";
select "STAT:";
select "  # of Papers that Use Evolve for Each Category";
select "  # of Relevant Papers for Each Category";
select "";

create table helper2c as --Counts Relevant Items
    select category, count(*) as relevant from journals group by category;
create table helper2d as --Counts Yes to Evolve
    select category, count(*) as yescount from journals where lower(evolve) = "yes" group by category;
create table table2e as
    select a.category || ": " || round(cast(b.yescount as float)/a.relevant*100,1) || "% (" || b.yescount || "/" || a.relevant || ")" from helper2c as a, helper2d as b where a.category = b.category;
select * from table2e;

select "";
select "---------------------------------";
select "STAT: Proportion of Evolve usage";
select "";

create table helper2f as --Counts Relevant Items
    select count(*) as relevant from journals;
create table helper2g as --Counts Yes to Evolve
    select count(*) as yescount from journals where lower(evolve) like "%yes%";
create table table2h as
    select round(cast(b.yescount as float)/a.relevant*100,1) || "% (" || b.yescount || "/" || a.relevant || ")" from helper2f as a, helper2g as b;
select * from table2h;

/*
select "";
select "---------------------------------";
select "NOTICE: Journal papers with no Yes/No for Evolve";
select "";

select "~ " || journal || ": (id: " || id || ")" from journals where evolve = "";
*/

select "";
select "---------------------------------";
select "STAT: Overall Proportion of substitute words usage";
select "Note: Papers that did indeed use evolve are not included here.";
select "";

create table helpernoevolve as --Counts Items that did not use Evolve
    select count(*) as relevant from journals where lower(evolve) like "%no%";

create table helperemerge as
    select count(*) as count from journals where lower(substitute) like "%emerge%";
select "Emerge: " || round(cast(b.count as float)/a.relevant*100,1) || "% (" || b.count || "/" || a.relevant || ")" from helpernoevolve as a, helperemerge as b;

create table helpermutate as
    select count(*) as count from journals where lower(substitute) like "%mutate%";
select "Mutate: " || round(cast(b.count as float)/a.relevant*100,1) || "% (" || b.count || "/" || a.relevant || ")" from helpernoevolve as a, helpermutate as b;

create table helperdevelop as
    select count(*) as count from journals where lower(substitute) like "%develop%";
select "Develop: " || round(cast(b.count as float)/a.relevant*100,1) || "% (" || b.count || "/" || a.relevant || ")" from helpernoevolve as a, helperdevelop as b;

create table helperadapt as
    select count(*) as count from journals where lower(substitute) like "%adapt%";
select "Adapt: " || round(cast(b.count as float)/a.relevant*100,1) || "% (" || b.count || "/" || a.relevant || ")" from helpernoevolve as a, helperadapt as b;

create table helperacquire as
    select count(*) as count from journals where lower(substitute) like "%acquire%";
select "Acquire: " || round(cast(b.count as float)/a.relevant*100,1) || "% (" || b.count || "/" || a.relevant || ")" from helpernoevolve as a, helperacquire as b;
select "";
select "---------------------------------";
