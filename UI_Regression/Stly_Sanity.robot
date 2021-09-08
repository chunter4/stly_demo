*** Settings ***
Documentation       Sightly Sanity Test Suite

Resource            ../Resource.txt

Suite Setup         Set URL And User Credentials
Suite Teardown      Close All Browsers
Test Setup          Set Selenium Timeout    ${STD_WAIT}


*** Variables ***
${good_baseline_xlsx}    .\\TestData\\PerformanceDetail_Campaign_Baseline_Good.xlsx
${bad_baseline_xlsx}     .\\TestData\\PerformanceDetail_Campaign_Baseline_Bad.xlsx


*** Keywords ***
Return Column Compare List
    ${col_list}=    Create List    1    2    3    4    5    6    7    8    9    10    11    12    13    14    15    16    17    18
    [Return]    ${col_list}


*** Test Cases ***
Order Sanity Test
    Create Browser Instance    ${URL}
    Login to TargetView

    #Click reports tab
    Click an Element    ${tab_reports}

    #Select second item in list
    Click an Element    ${checkbox_seconditem}

    #Click Create Report button
    Click an Element    ${button_createreport}

    #Click Performance Detail Report radio dial
    Click an Element    ${radiodial_reportgen_perfdetailreport}

    #Select report options
    Click an Element    ${dropdown_reportgen_grouping}
    Click an Element    ${dropdown_reportgen_grouping_campaign}

    Click an Element    ${dropdown_reportgen_costbasis}
    Click an Element    ${dropdown_reportgen_costbasis_all}

    Click an Element    ${dropdown_reportgen_granularity}
    Click an Element    ${dropdown_reportgen_granularity_summary}

    Click an Element    ${dropdown_reportgen_addtlcolumns}
    Click an Element    ${dropdown_reportgen_addtlcolumns_none}

    Click an Element    ${dropdown_reportgen_timeperiod}
    Click an Element    ${dropdown_reportgen_timeperiod_alltime}

    #Click Run Reports button
    Click an Element    ${button_reportgen_runreports}

    #Wait until the file completes downloading and return the filename
    ${filename}=    Wait Until File Download is Finished

    #Get the list of columns to compare
    ${col_list}=    Return Column Compare List

    #Compare against a known good baseline
    ${result}=    compare_excel_files    ${good_baseline_xlsx}    ${filename}    6    ${col_list}
    Run Keyword If    ${result}==${False}    fail    Differences found comparing xlsx files!

    #Compare against a known bad baseline
    ${result}=    compare_excel_files    ${bad_baseline_xlsx}    ${filename}    6    ${col_list}
    Run Keyword If    ${result}==${False}    fail    Differences found comparing xlsx files!
