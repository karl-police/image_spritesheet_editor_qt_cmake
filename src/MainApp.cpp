// MainApp.cpp : Defines the entry point for the application.
//

#include "MainApp.h"
#include <QApplication>
#include <QMainWindow>

//#include "generated/ui_MainWindow.h"

using namespace std;

int main(int argc, char* argv[])
{
    QApplication app(argc, argv);

    QMainWindow mainWindow;
    mainWindow.show();

    return app.exec();
}
