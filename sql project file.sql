
                                         -- Domine :HR Analytics    project: employee Retention 
-- 1.Average Attrition rate for all Departments 
-- 2.Average Hourly rate of Male Research Scientist 
-- 3.Attrition rate Vs Monthly income stats
-- 4.Average working years for each Department
-- 5.Job Role Vs Work life balance 
-- 6.Attrition rate Vs Year since last promotion relation




use sample_project;
drop table  hr_1;
drop table  hr_2;
show tables;
							 
                             --   1.Average Attrition rate for all Departments
select * from hr_1;
select * from hr_2;
select department, count(case when attrition ="yes" then 1 end)/count(*)*100 as department_wise_avg_attrition_rate from hr_1 
group by department;
                                                                          
													
select avg(attrition_rate) as avg_attrition_rate from (select department,(count(case when attrition ="yes" then 1 end)/count(*)*100)
                                                        as attrition_rate
                                                        from 
                                                        hr_1 group by department)
                                                        as department_attrition_rate;

								
                                -- 2. Average Hourly rate of Male Research Scientist
select * from hr_1;
select * from hr_2;
select gender, jobrole, avg(HourlyRate) as avg_hoyrly_rate from hr_1 where gender= "male" and jobrole="research scientist";

                              
                              -- 3.Attrition rate Vs Monthly income states
select * from hr_1;
select * from hr_2;
select  min(MonthlyIncome), max(MonthlyIncome) from hr_2;
select case when MonthlyIncome<15000 then "low"
			when MonthlyIncome between 15000 and 30000 then "medium"
            when monthlyIncome>30000 then "high"
            end as montlyIncomeStatus, count(*) as employeecount, count( case when attrition ="yes" then 1 end ) as attritioncount,
            count(case when attrition="yes" then 1 end)*100/count(*) as attritionrate 
            from hr_1 join hr_2 on hr_1.EmployeeNumber= hr_2.`Employee ID`
            group by 
            montlyIncomeStatus;

                         
                         -- 4.Average working years for each Department( in years) method 2
select * from  hr_1;
select * from hr_2;
select department, concat(floor(avg(TotalWorkingYears))," years ", 
                          floor((avg(TotalWorkingYears)-floor(avg(TotalWorkingYears)))*12)," months ") as avg_total_working_years from hr_1
                          join hr_2 on hr_1.EmployeeNumber=hr_2.`Employee Id`
                          group by Department
                          order by Department;

        
                      


   

-- example part extracting years, months and days.
-- average value 5.65
select floor(5.65) as "years";   -- 5years
select ((5.65-floor(5.65))*12) as "months";   -- 5-5.65=0.65*12 = floor(7.8)= 7


                                             -- 5.Job Role Vs Work life balance
select * from hr_1;
select * from hr_2;
select jobRole,round(avg(WorkLifeBalance)) as avg_work_life_balance from hr_1
join hr_2 on hr_1.EmployeeNumber= hr_2.`Employee ID`
group by jobrole
order by avg_work_life_balance desc;


                                      -- 6.Attrition rate Vs Year since last promotion relation
 select * from hr_1;
 select * from hr_2;
 select  YearsSinceLastPromotion,count(*) as toatal_employees, sum(case when attrition= "yes" then 1 else 0 end) as attrited_employees,
                                      sum(case when attrition= "yes" then 1 else 0 end)*100/count(*) as attrited_rate from hr_1
                                      join hr_2 on hr_1.EmployeeNumber=hr_2.`Employee ID`
                                      group by YearsSinceLastPromotion
                                      order by YearsSinceLastPromotion;
 





                                        
                                        
                                        
                                        
                                        

