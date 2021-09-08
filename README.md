# Dev Environment Setup
    - Clone this repository to a clean Windows 10 machine
    - Install Python 3.7 (in Requirements directory) and PIP
    - Install PyCharm Community Edition (https://www.jetbrains.com/pycharm/download/)
        - Open the repository in PyCharm
    - Install the Intellibot plugin
    - Run 'Execution Environment Setup' steps
    - Add Python as the interpretor in PyCharm

# Execution Environment Setup
    - Clone this repository to a clean Windows 10 machine
    - Navigate to the 'Requirements' directory
    - Run the script "Install_Chrome_ChromeDriver.sh" (setup for Linux nodes)
        - Downloads the latest chrome, isntalls it and downloads the matching chromedriver.exe
    - Run the command "python Install_Dependencies.py"
        - PIP installs all project dependencies per 'Requirements.txt'

# Execute the Automation
    - Modify the Resource.txt file, if needed (logins/passwords/urls/email addresses)
    - Make sure to execute the automation from the project's root directory
    - UI Regression Test - Execute by running the following command:
        - "robot --outputdir Results\Stly_Regression --output output.xml --variable ENVIRONMENT:Staging --variable stly_username:nick@sightly.com --variable stly_password:a UI_Regression\Stly_Sanity.robot"
