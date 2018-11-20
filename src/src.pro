TEMPLATE = subdirs

# Libraries

src_gestures_lib.subdir = UbuntuGestures
src_gestures_lib.target = sub-gestures-lib
SUBDIRS += src_gestures_lib

src_metrics_lib.subdir = UbuntuMetrics
src_metrics_lib.target = sub-metrics-lib
SUBDIRS += src_metrics_lib

src_toolkit_lib.subdir = UbuntuToolkit
src_toolkit_lib.target = sub-toolkit-lib
src_toolkit_lib.depends = sub-gestures-lib sub-metrics-lib
SUBDIRS += src_toolkit_lib


# QML modules
src_metrics_module.subdir = imports/Metrics
src_metrics_module.target = sub-metrics-module
src_metrics_module.depends = sub-metrics-lib
SUBDIRS += src_metrics_module

src_components_module.subdir = imports/Components
src_components_module.target = sub-components-module
src_components_module.depends = sub-toolkit-lib
SUBDIRS += src_components_module

src_layouts_module.subdir = imports/Layouts
src_layouts_module.target = sub-layouts-module
SUBDIRS += src_layouts_module

src_performance_metrics_module.subdir = imports/PerformanceMetrics
src_performance_metrics_module.target = sub-performance-metrics-module
SUBDIRS += src_performance_metrics_module
