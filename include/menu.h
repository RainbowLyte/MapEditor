#ifndef MENU_H
#define MENU_H

#include <gtk/gtk.h>

GtkMenuBar* menu_new(gpointer);
static void menu_item_new(GtkMenu*, const gchar*, GCallback, gpointer);


#endif