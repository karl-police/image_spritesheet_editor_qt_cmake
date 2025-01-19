// MainApp.cpp : Defines the entry point for the application.
//

#include "MainApp.hpp"
#include <QApplication>
#include <QMainWindow>

using namespace std;

int main(int argc, char* argv[])
{
    QApplication a(argc, argv);
    QMainWindow w;
    w.show();

    return a.exec();
}
