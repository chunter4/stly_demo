FROM python:3

RUN python3 -m pip install robotframework
RUN python3 -m pip install robotframework-seleniumlibrary
RUN python3 -m pip install robotframework-selenium2library
RUN python3 -m pip install robotframework-excellib
RUN python3 -m pip install robotframework-openpyxllib
RUN python3 -m pip install robotframework-httplibrary
RUN python3 -m pip install robotframework-screencaplibrary
RUN python3 -m pip install selenium
RUN python3 -m pip install setuptools
RUN python3 -m pip install xlrd
RUN python3 -m pip install openpyxl
RUN python3 -m pip install XlsxWriter
RUN python3 -m pip install xlutils