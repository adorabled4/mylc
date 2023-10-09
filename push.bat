@echo off

REM 检查是否输入了message参数
IF "%~1"=="" (
    echo 请提供commit message作为参数
    exit /b
)

REM 执行git add、git commit和git push操作
git add .
git commit -m "%~1"
git push origin master

REM 显示操作结果
IF %ERRORLEVEL% NEQ 0 (
    echo 提交失败，请检查错误信息。
) ELSE (
    echo 提交成功！
)