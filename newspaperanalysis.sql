.read newspaperdata.sql
--.read newspaperpotentials.sql

select "---------------------------------";
select "TABLE 1:";
select "  # of Articles that Use Evolve for Each Newspaper";
select "  # of Relevant Articles for Each Newspaper";
select "";

create table helper1a as --Counts Relevant Items
    select newspaper, count(*) as relevant from newspapers group by newspaper;
create table helper1b1 as --Counts Yes to Evolve
    select newspaper, count(*) as yescount from newspapers where lower(evolve) = "yes" group by newspaper;
create table helper1b2 as --Lists all Items with yescount = null if 0 Yes to Evolve
    select newspapers.newspaper as newspaper, yescount from newspapers left join helper1b1 on helper1b1.newspaper=newspapers.newspaper group by newspapers.newspaper;
create table helper1b3 as --Replace all null values with 0
    select newspaper, ifnull(yescount,0) as yescount from helper1b2;
create table table1 as
    select a.newspaper || ": " || round(cast(b.yescount as float)/a.relevant*100,1) || "% (" || b.yescount || "/" || a.relevant || ")" from helper1a as a, helper1b3 as b where a.newspaper = b.newspaper;
select * from table1;

select "";
select "---------------------------------";
select "TABLE 2:";
select "  # of Newspaper Articles that Use Evolve for Each Category";
select "  # of Relevant Newspaper Articles for Each Category";
select "";

create table helper2a as --Counts Relevant Items
    select category, count(*) as relevant from newspapers group by category;
create table helper2b1 as --Counts Yes to Evolve
    select category, count(*) as yescount from newspapers where lower(evolve) = "yes" group by category;
create table helper2b2 as --Lists all Items with yescount = null if 0 Yes to Evolve
    select newspapers.category as category, yescount from newspapers left join helper2b1 on helper2b1.category=newspapers.category group by newspapers.category;
create table helper2b3 as --Replace all null values with 0
    select category, ifnull(yescount,0) as yescount from helper2b2;
create table table2 as
    select a.category || ": " || round(cast(b.yescount as float)/a.relevant*100,1) || "% (" || b.yescount || "/" || a.relevant || ")" from helper2a as a, helper2b3 as b where a.category = b.category;
select * from table2;

select "---------------------------------";
select "STAT: FOR HIV NEWSPAPERS";
select "  # of Articles that Use Evolve for Each Newspaper";
select "  # of Relevant Articles for Each Newspaper";
select "";

create table helper3a as --Counts Relevant Items
    select newspaper, count(*) as relevant from newspapers where category = "HIV Resistance" group by newspaper;
create table helper3b1 as --Counts Yes to Evolve
    select newspaper, count(*) as yescount from newspapers where lower(evolve) = "yes" and category = "HIV Resistance" group by newspaper;
create table helper3b2 as --Lists all Items with yescount = null if 0 Yes to Evolve
    select newspapers.newspaper as newspaper, yescount from newspapers left join helper3b1 on helper3b1.newspaper=newspapers.newspaper where category = "HIV Resistance" group by newspapers.newspaper;
create table helper3b3 as --Replace all null values with 0
    select newspaper, ifnull(yescount,0) as yescount from helper3b2;
create table table3 as
    select a.newspaper || ": " || round(cast(b.yescount as float)/a.relevant*100,1) || "% (" || b.yescount || "/" || a.relevant || ")" from helper3a as a, helper3b3 as b where a.newspaper = b.newspaper;
select * from table3;

select "---------------------------------";
select "STAT: FOR CANCER NEWSPAPERS";
select "  # of Articles that Use Evolve for Each Newspaper";
select "  # of Relevant Articles for Each Newspaper";
select "";

create table helper4a as --Counts Relevant Items
    select newspaper, count(*) as relevant from newspapers where category = "Tumor Resistance" group by newspaper;
create table helper4b1 as --Counts Yes to Evolve
    select newspaper, count(*) as yescount from newspapers where lower(evolve) = "yes" and category = "Tumor Resistance" group by newspaper;
create table helper4b2 as --Lists all Items with yescount = null if 0 Yes to Evolve
    select newspapers.newspaper as newspaper, yescount from newspapers left join helper4b1 on helper4b1.newspaper=newspapers.newspaper where category = "Tumor Resistance" group by newspapers.newspaper;
create table helper4b3 as --Replace all null values with 0
    select newspaper, ifnull(yescount,0) as yescount from helper4b2;
create table table4 as
    select a.newspaper || ": " || round(cast(b.yescount as float)/a.relevant*100,1) || "% (" || b.yescount || "/" || a.relevant || ")" from helper4a as a, helper4b3 as b where a.newspaper = b.newspaper;
select * from table4;


select "";
select "---------------------------------";
select "NOTICE: Newspaper articles with no Yes/No for Evolve";
select "";

select "~ " || newspaper || ": " || title from newspapers where evolve = "";


select "";
select "---------------------------------";
select "STAT: Overall Proportion of Evolve usage";
select "";

create table helper1c as --Counts Relevant Items
    select count(*) as relevant from newspapers;
create table helper1d as --Counts Yes to Evolve
    select count(*) as yescount from newspapers where lower(evolve) like "%yes%";
create table table1e as
    select round(cast(b.yescount as float)/a.relevant*100,1) || "% (" || b.yescount || "/" || a.relevant || ")" from helper1c as a, helper1d as b;
select * from table1e;

select "";
select "---------------------------------";
select "STAT: Overall Proportion of substitute words usage";
select "Note: Articles that did indeed use evolve are not included here.";
select "";

create table helpernoevolve as --Counts Items that did not use Evolve
    select count(*) as relevant from newspapers where lower(evolve) like "%no%";

create table helperemerge as
    select count(*) as count from newspapers where lower(substitute) like "%emerge%";
select "Emerge: " || round(cast(b.count as float)/a.relevant*100,1) || "% (" || b.count || "/" || a.relevant || ")" from helpernoevolve as a, helperemerge as b;

create table helpermutate as
    select count(*) as count from newspapers where lower(substitute) like "%mutate%";
select "Mutate: " || round(cast(b.count as float)/a.relevant*100,1) || "% (" || b.count || "/" || a.relevant || ")" from helpernoevolve as a, helpermutate as b;

create table helperdevelop as
    select count(*) as count from newspapers where lower(substitute) like "%develop%";
select "Develop: " || round(cast(b.count as float)/a.relevant*100,1) || "% (" || b.count || "/" || a.relevant || ")" from helpernoevolve as a, helperdevelop as b;

create table helperadapt as
    select count(*) as count from newspapers where lower(substitute) like "%adapt%";
select "Adapt: " || round(cast(b.count as float)/a.relevant*100,1) || "% (" || b.count || "/" || a.relevant || ")" from helpernoevolve as a, helperadapt as b;

create table helperacquire as
    select count(*) as count from newspapers where lower(substitute) like "%acquire%";
select "Acquire: " || round(cast(b.count as float)/a.relevant*100,1) || "% (" || b.count || "/" || a.relevant || ")" from helpernoevolve as a, helperacquire as b;
select "";
select "---------------------------------";

/*
select "TABLE 2: Analysis with Keywords";
select "  Which ones led to higher proportions of articles?"; --can't do yet
select "  Relevant articles?";
select "  Evolve usage?";
select "  What substitute words were the most common for each keyword?";
select "";

create table table2b as
    select keyword, "# of relevant articles: " || count(*) from newspapers group by keyword;
select * from table2b;
select "";
create table table2c as
    select keyword, "Yes: " || count(*) from newspapers where lower(evolve) = "yes" group by keyword union
    select keyword, "No: " || count(*) from newspapers where lower(evolve) = "no" group by keyword;
select * from table2c;
select "";
create table table2d as
    select keyword, "Emerge: " || count(*) from newspapers where lower(substitute) like "%emerge%" group by keyword union
    select keyword, "Mutate: " || count(*) from newspapers where lower(substitute) like "%mutate%" group by keyword union
    select keyword, "Develop: " || count(*) from newspapers where lower(substitute) like "%develop%" group by keyword union
    select keyword, "Increase: " || count(*) from newspapers where lower(substitute) like "%increase%" group by keyword union
    select keyword, "Rise: " || count(*) from newspapers where lower(substitute) like "%rise%" group by keyword;
select * from table2d;
*/
