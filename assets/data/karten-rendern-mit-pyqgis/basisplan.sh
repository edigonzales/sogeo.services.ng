#!/bin/bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/stefan/Apps/qgis_master/lib
export PYTHONPATH=$PYTHONPATH:/home/stefan/Apps/qgis_master/share/qgis/python

python basisplan.py
