CC = gcc

SDLCFLAGS = $$(pkg-config --libs --cflags gtk+-2.0)
SDLLDFLAGS = $$(pkg-config --libs --cflags gtk+-2.0)

CFLAGS = -Wall -O0 -g -std=c99 -Iinclude/ $(SDLCFLAGS)
LDFLAGS = $$(pkg-config --libs --cflags gtk+-2.0)

BINDIR = bin
BIN = map_editor

SRCDIR = src
SRC  = $(wildcard $(SRCDIR)/*.c)

OBJDIR = .obj
OBJ  = $(SRC:$(SRCDIR)/%.c=$(OBJDIR)/%.o)

DEPDIR = .dep
DEP = $(SRC:$(SRCDIR)/%.c=$(DEPDIR)/%.d)

.PHONY: all clean mrproper archive

all : $(BIN)

$(BIN) : $(OBJ)
	$(CC) -o $(BINDIR)/$@ $(OBJ) $(LDFLAGS)

$(OBJDIR)/%.o : $(SRCDIR)/%.c $(DEPDIR)/%.d
	$(CC) -c $(CFLAGS) $< -o $@

$(DEPDIR)/%.d : $(SRCDIR)/%.c
	@$(CC) -Iinclude/ -MT"$(<:$(SRCDIR)/%.c=$(OBJDIR)/%.o)" -MM -o $@ $< 

$(OBJ) : $(OBJDIR)

$(DEP) : $(DEPDIR)

$(BIN) : $(BINDIR)

$(DEPDIR) $(OBJDIR) $(BINDIR):
	-mkdir $@

clean :
	-rm -rf $(BINDIR) $(OBJDIR) $(DEPDIR)
	
mrproper : clean
	-rm -rf .project .cproject .settings

archive:
	-zip -9 -r map_editor-`date +'%y-%m-%d-%Hh%M'`.zip . -x "*/\.*" -x "\.*" -x "bin/*" -x "*.zip" -x "*~"

ifneq ($(wildcard .dep),)
-include $(DEP)
endif
