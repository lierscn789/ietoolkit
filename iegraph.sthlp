{smcl}
{* 26 Dec 2016}{...}
{hline}
help for {hi:iegraph}
{hline}

{title:Title}

{phang2}{cmdab:iegraph} {hline 2} Generates graphs based on regressions with treatment dummies common in impact evaluations. 

{title:Syntax}

{phang2}
{cmdab:iegraph} {varlist} 
, [{cmd:noconfbars} {cmdab:ti:tle(}{it:string}{cmd:)}
{cmdab:save(}{it:string}{cmd:)} {cmdab:confbarsnone(}{it:varlist}{cmd:)}
{it:any towway graph options}
]

{marker opts}{...}
{synoptset 22}{...}
{synopthdr:options}
{synoptline}
{synopt :{cmd:noconfbars}} Removes the confidence interval bars from graphs for all treatments.{p_end}
{synopt :{cmdab:ti:tle(}{it:string}{cmd:)}} Manually sets the title of the graph.{p_end}
{synopt :{cmdab:save(}{it:string}{cmd:)}} Sets the filename and the directory to which the graph will be set.{p_end}
{synopt :{cmdab:confbarsnone(}{it:varlist}{cmd:)}} Removes confidence interval bars from only the {it:varlist} listed.{p_end}
{synopt :{cmdab:yzero}} Forces y-axis on the graph to start at 0.{p_end}
{synopt :{cmdab: Graph Options}} Options that can be used with normal graph commands can also be used. See example 2 for details.{p_end}
{synoptline}

{marker desc}
{title:Description}

{pstd}{cmdab:iegraph} This command creates bar graphs on the based on the coefficients 
	of treatment dummies in regression results. This command is developed for reading 
	stored results of from two types of impact evaluation regression models, but there 
	are countless of other examples where the command also can be used. {cmd:iegraph} must 
	be used immediately after running the regression or as long as the regression result is 
	still stored in or restored to Stata's {help ereturn} results. 
	
{pstd}{bf:Model 1: OLS with Treatment Dummies}{break}The most typical impact evaluation regression is 
	to have the outcome variable as the dependent variable and one dummy for each 
	treatment arm where control is the omitted category. These regressions can also include 
	covariates, fixed effects etc., but as long as the treatment status is defined by 
	mutually exclusive dummy variables. See especially example 1 and 2 below. This command 
	works with any number of treatment arms but works best from two arms (treatment 
	and control) to five treatment arms (4 different treatments and control). More 
	arms than that may result in a still correct but perhaps cluttered graph.
	
{pstd}{bf:Model 2: Difference-in-Differences}{break}Another typical regression model in impact 
	evaluations are difference-in-difference (Diff-in-Diff) models with two treatment arms (treatment 
	and control) and two time periods. If the Diff-in-Diff regression is specified as having the 
	outcome variable as the dependent variable and three dummy variables (time, treatment 
	and timeXtreatment) as the independent variables, then this command will produce a nice 
	graph. Controls, treatment effects etc. may be added to the regression model. See especially example 3.

{pstd}{bf:Graph Output}{break}The graph generated by this command is created using the following values. The 
	control bar is the mean of the outcome variable for the control group. It is not 
	the constant from the regression as those are not identical if, for example, fixed effects 
	and covariates were used. For each treatment group the bar is the sum of the value 
	of the control bar and the beta coefficient in the regression of the corresponding 
	treatment dummy. The confidence intervals are calculated from the variance in the 
	beta coefficients in the regression.{p_end}

{pstd}The graph also includes the N for each treatment arm in the regression and uses 
	that value as labels on the x-axis. Stars are added to this value if the corresponding 
	coefficient is statistically different from zero in the regression{p_end}	
	
{marker optslong}
{title:Options}

{phang}{cmd:noconfbars} Removes the confidence interval bars from graphs for all 
	treatments. The default value for the confidence interval bars ar 95%. {p_end}

{phang}{cmdab:ti:tle(}{it:string}{cmd:)} Manually sets the title of the graph.{p_end}

{phang}{cmdab:save(}{it:string}{cmd:)} Sets the filename and the directory to which
	the graph will be set.{p_end}

{phang}{cmdab:confbarsnone(}{it:varlist}{cmd:)} Removes confidence interval bars 
	from only the {it:varlist} listed. The remaining variables in the graphs which 
	have not been specified in {cmdab:confbarsnone} will still have the confidence
	interval bars. {p_end}

{phang}{cmdab:yzero} Manually sets the y-axis of the graph to start at zero instead of the Stata default.{p_end}

{marker optslong}
{title:Examples}

{pstd} {hi:Example 1.}

{pmore} {inp:regress} {it:outcomevar treatment_dummy}{break}
		{inp:iegraph} {it:treatment_dummy} , {inp:title({it:"Treatment Effect on Outcome"})}

{pmore}In the example above, there is only two treatment arms (treatment and 
		control). {it:treatment_dummy} has a 1 for all treatment observations and 
		a 0 for all control observations. The graph will have one bar for control and 
		it shows the mean for {it:outcomevar} for all observations in control. The 
		second bar in the graph will be the sum of that mean and the coefficient 
		for {it:treatment_dummy} in the regression. The graph will also have the 
		title: Treatment Effect on Outcome.

{pstd} {hi:Example 2.}

{pmore} {inp:regress} {it:income tmt_1 tmt_2 age education}{inp:, cluster(}{it:district}{inp:)}{break}
		{inp:iegraph} {it:tmt_1 tmt_2}{inp:, noconfbars yzero title({it:"Treatment effect on income"}) }

{pmore}In the example above, the treatment effect on income in reserached. There 
		are three treatment arms; control, treatment 1 ({it:tmt_1}) and treatment
		2 ({it:tmt_2}). It is important that no observation has the value 1 in 
		both {it:tmt_1} and {it:tmt_2} (i.e. no observation is in more than one
		treatment) and some observations must have the value 0 in both {it:tmt_1} 
		and {it:tmt_2} (i.e. control observations). The variables {it:age} and 
		{it:education} are covariates (control variables) and is not included 
		in {cmd:iegraph}. {inp:noconfbars} omitts the confidence intervall bars
		, and {inp:yzero} sets the y-axis to start at 0.

{pstd} {hi:Example 3.}

{pmore} {inp:regress} {it:chld_wght time treat timeXtreat}{break}
		{inp:iegraph} {it:time treat timeXtreat} {inp:, title({it:"Treatment effect on Child Weight (Diff-in-Diff)"})}
		
{pmore}In the example above, the data set is a panel data set with two time 
		periods and the regression estimates the treatment effect on child weight
		using a Difference-in-Differences model.
		The dummy variable {it:time} indicates if it is time period 0 or 1.
		The dummy variable {it:treat} indicates if the observation is treatment 
		or control. {it:timeXtreat} is the interaction term of {it:time} 
		and {it:treat}. This the standard way to set up a Difference-in-Differences
		regression model.

{pstd} {hi:Example 4.}

{pmore} {inp:regress} {it:harvest T1 T2 T3 } {break}
		{inp:iegraph} {it:T1 T2 T3} {inp:, title({it:"Treatment effect on harvest"}) 
		xlabel(,angle(45)) yzero ylabel(minmax) save({it:"$Output/Graph1.gph"})}
		
{pmore}The example above shows how to save a graph to disk. It also shows that 
	most two-way graph options can be used. In this example the {cmd:iegraph} 
	option {cdm:yzero} conflicts with the two-way option {cmd:ylabel(minmax)}. 
	In such a case the user specified option takes presidence over {cmd:iegraph} 
	options like {cdm:yzero}.
		
	
{title:Acknowledgements}

{phang}We would like to acknowledge the help in testing and proofreading we received in relation to this command and help file from (in alphabetic order):{p_end}
{pmore}Michael Orevba{break}Ahmad Zia Wahdat{break}

{title:Author}

{phang}Kristoffer Bjarkefur & Mrijan Rimal, The World Bank, DECIE

{phang}Please send bug-reports, suggestions and requests for clarifications
		 writing "ietools iegraph" in the subject line to:{break}
		 kbjarkefur@worldbank.org

{phang}You can also see the code, make comments to the code, see the version
		 history of the code, and submit additions or edits to the code through
		 the github repository of ietoolkit:{break}
		 {browse "https://github.com/worldbank/ietoolkit"}
