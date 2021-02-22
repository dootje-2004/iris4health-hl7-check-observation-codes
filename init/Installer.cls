Class App.Installer
{

XData AppInstall [ XMLNamespace = INSTALLER ]
{
<Manifest>
  <Default Name="NS" Value="HL7"/>
  <Var Name="SRC" Value='#{$system.Util.GetEnviron("SRC_DIR")}'/>

  <Namespace Name="${NS}" Code="${NS}" Data="${NS}" Create="yes" Ensemble="1">
    <Configuration>
      <Database Name="${NS}" Dir="${MGRDIR}/${NS}" Create="yes"/>
    </Configuration>
  </Namespace>
</Manifest>
}

ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "AppInstall")
}

}
