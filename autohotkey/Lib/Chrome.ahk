class Chrome
{
    static RunChromeApp(AppId) {
        LocalAppdata := EnvGet("LocalAppData")
        Run(Format("{1:s}/BraveSoftware/Brave-Browser/Application/chrome_proxy.exe --profile-directory=Default --app-id={2:s}", LocalAppData, AppId))
    }
}
