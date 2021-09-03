*** Settings ***
Documentation       Pottery Barn Sanity Test Suite
Resource            ../Resource.txt
Resource            ./Objects/PB_Objects.txt
Resource            ./Keywords/PB_Keywords.txt

Suite Setup         Set URL And User Credentials
Suite Teardown      Close All Browsers
Test Setup          Set Selenium Timeout    ${STD_WAIT}


*** Test Cases ***
Order Sanity Test
    Create Browser Instance    ${URL}
    ${pass_fail}    ${val}    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${popUpAd}    timeout=10
    Run Keyword If    '${pass_fail}'=='PASS'    Click Element    ${popUpAd}
    Search For Item    sectional
    Select Search Result Item    10
    Wait Until Element Is Visible    ${itemOneQty}    timeout=${WEB_TIMEOUT}
    Input Text Into Field    ${itemOneQty}    1
    Input Text Into Field    ${itemTwoQty}    1
    Click an Element    ${itemTwoColorOne}
    Click an Element    ${addToCartButton}
    Click an Element    ${contShoppingButton}
    Search For Item    pillow
    Select Search Result Item    1
    Click an Element    ${itemOneColorOne}
    Input Text Into Field    ${itemOneQty}    1
    Click an Element    ${addToCartButton}
    Click an Element    ${checkoutButton}
    Click an Element    ${ccRadioDial}
    Click an Element    ${checkoutButtonCart}
    Click an Element    ${guestCheckoutButton}
    Input Text Into Field    ${checkoutFullName}    Test Er
    Input Text Into Field    ${checkoutPhone}    9165551234
    Click an Element    ${checkoutShippingCont}

    ${errorMsg}    Get Text    ${checkoutAddressErr}
    Should Contain    ${errorMsg}    Please enter your Address

    ${errorMsg}    Get Text    ${checkoutCityErr}
    Should Contain    ${errorMsg}    Please enter your City

    ${errorMsg}    Get Text    ${checkoutStateErr}
    Should Contain    ${errorMsg}    Please select a State

    ${errorMsg}    Get Text    ${checkoutZipErr}
    Should Contain    ${errorMsg}    Please enter your ZIP

    Input Text Into Field    ${checkoutAddress}    3201 Mortara Circle
    Input Text Into Field    ${checkoutCity}    Placerville
    Select From List By Value    ${checkoutState}    CA
    Click an Element    ${checkoutZip}
    Input Text Into Field    ${checkoutZip}    95667

    #continue button (shipping)
    Click an Element    ${checkoutShippingCont}

    #continue button (delivery and gift options)
    ${shadowElem}=    Return Shadow DOM Element    ${checkoutShipCont}
    Click an Element    ${shadowElem}

    #Place order
    ${shadowElem}=    Return Shadow DOM Element    ${checkoutPlaceOrder}
    Click an Element    ${shadowElem}

    #email error
    ${shadowElem}=    Return Shadow DOM Element    ${checkoutEmailErr1}
    ${errorMsg}    Get Text    ${shadowElem}
    Should Contain    ${errorMsg}    Please enter a valid email address to place your order.

    Click an Element    ${checkoutEmail}
    Input Text Into Field    ${checkoutEmail}    test@tester.com

    #Place order
    ${shadowElem}=    Return Shadow DOM Element    ${checkoutPlaceOrder}
    Click an Element    ${shadowElem}

    ${shadowElem}=    Return Shadow DOM Element    ${checkoutErr}
    ${errorMsg}    Get Text    ${shadowElem}
    Should Contain    ${errorMsg}    Please enter your credit card number.

    Click an Element    ${checkoutCCNum}
    Input Text Into Field    ${checkoutCCNum}    4111111111111111

    #Place order
    ${shadowElem}=    Return Shadow DOM Element    ${checkoutPlaceOrder}
    Click an Element    ${shadowElem}

    ${shadowElem}=    Return Shadow DOM Element    ${checkoutErr}
    ${errorMsg}    Get Text    ${shadowElem}
    Should Contain    ${errorMsg}    Please specify your credit card expiration month.

    Click an Element    ${checkoutCCExp}
    Input Text Into Field    ${checkoutCCExp}    12/23

    #Work around some error messaging weirdness (maybe a bug?)
    Click an Element    ${checkoutCCCVN}
    Click an Element    ${checkoutCCExp}

    #Place order
    ${shadowElem}=    Return Shadow DOM Element    ${checkoutPlaceOrder}
    Click an Element    ${shadowElem}

    ${shadowElem}=    Return Shadow DOM Element    ${checkoutErr}
    ${errorMsg}    Get Text    ${shadowElem}
    Should Contain    ${errorMsg}    Please enter the credit card verification number. For assistance in locating this number, please call Customer Service at 1.888.779.5176.

    Click an Element    ${checkoutCCCVN}
    Input Text Into Field    ${checkoutCCCVN}    213

    #Place order
    ${shadowElem}=    Return Shadow DOM Element    ${checkoutPlaceOrder}
    Click an Element    ${shadowElem}

    ${shadowElem}=    Return Shadow DOM Element    ${checkoutErr}
    ${errorMsg}    Get Text    ${shadowElem}
    Should Contain    ${errorMsg}    Please confirm your payment and billing information. For further assistance, you can call 1.888.779.5176. If having trouble using a Key Rewards Credit Card, you may need to activate your card by calling Capital One at 844.217.6926.
