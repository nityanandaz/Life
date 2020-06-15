ifeq ($(GNUSTEP_MAKEFILES),)
 GNUSTEP_MAKEFILES := $(shell gnustep-config --variable=GNUSTEP_MAKEFILES 2>/dev/null)
endif

ADDITIONAL_OBJCFLAGS += -std=gnu11
CC = clang
CXX = clang++

include $(GNUSTEP_MAKEFILES)/common.make

APP_NAME = Life
Life_OBJC_FILES = Grid.m Cell.m GridVisitors.m LifeAppDelegate.m LifeController.m GridView.m main.m NSNumber+Times.m
Life_HEADER_FILES = Grid.h Cell.h GridVisitors.h LifeAppDelegate.h LifeController.h GridView.h NSNumber+Times.h
Life_RESOURCE_FILES = Window.gsmarkup Menu.gsmarkup

ifeq ($(FOUNDATION_LIB), apple)
  ADDITIONAL_INCLUDE_DIRS += -framework Renaissance
  ADDITIONAL_GUI_LIBS += -framework Renaissance
else
  ADDITIONAL_GUI_LIBS += -lRenaissance
endif

include $(GNUSTEP_MAKEFILES)/application.make

TOOL_NAME = LifeTest
LifeTest_OBJC_FILES = Grid.m Cell.m GridVisitors.m TestDefinitions.m NSNumber+Times.m
LifeTest_OBJCC_FILES = LifeTests.mm
LifeTest_HEADER_FILES = catch.hpp Grid.h GridVisitors.h Cell.h NSNumber+Times.h TestDefinitions.h

include $(GNUSTEP_MAKEFILES)/tool.make

runtests: LifeTest
	obj/LifeTest
