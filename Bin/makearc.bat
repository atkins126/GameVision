@echo off
if exist "..\..\..\..\docs\LICENSE.rtf" (
  copy "..\..\..\..\docs\LICENSE.rtf" arc\startup\
)
if exist "..\..\..\..\docs\README.rtf" (
  copy "..\..\..\..\docs\README.rtf" arc\startup\
)
GVArc Data.arc arc
echo(
pause