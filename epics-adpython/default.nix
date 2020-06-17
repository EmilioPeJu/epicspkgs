{ python, pythonPackages, buildEpicsModule, epics-asyn, epics-adcore }:

buildEpicsModule {
  name = "epics-adpython";
  buildInputs = [ python pythonPackages.numpy epics-asyn epics-adcore ];
  postConfigure = ''
    sed -i 's|PYTHON_PREFIX=.*|PYTHON_PREFIX=${python}|g' configure/RELEASE
  '';
  src = builtins.fetchGit {
    url = "https://github.com/dls-controls/adPython.git";
    ref = "master";
  };
}
