# pip

## List outdated packages
```bash
pip list --outdated
```

## Generate dependencies file
```
pip freeze > requirements.txt
```

## Install dependencies
```
pip install -r requirements.txt
```

## Working with different python versions
Install python env
```bash
virtualenv -p $PYTHON_VERSION $ENV_DIR
virtualenv -p python3 venv
virtualenv -p python2 venv
```
Activation/Deactivation
```bash
source $ENV_DIR/bin/activate
deactivate
```

