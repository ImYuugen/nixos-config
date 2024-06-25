{ pkgsSet
, ...
}:
{
  home.packages = [
    pkgsSet.stable.xsecurelock
  ];

  home.sessionVariables = {
    XSECURELOCK_PASSWORD_PROMPT = "time";
    XSECURELOCK_SAVER = "saver_blank";
  };
}
