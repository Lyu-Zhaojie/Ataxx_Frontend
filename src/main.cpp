#include "GameData.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <Windows.h>
#include <thread>

void Load();
void Register(QQmlApplicationEngine &engine);
void ThrdFun();

constexpr char MEMORY_NAME[17]{"65b83838cd2e593b"};

GameData gameData;
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    Load();
    Register(engine);
    std::thread thrd(ThrdFun);
    thrd.detach();
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}
void Load()
{
    gameData.fileMapPointer = reinterpret_cast<char *>(CreateFileMapping(INVALID_HANDLE_VALUE,
                                                                         nullptr,
                                                                         PAGE_READWRITE,
                                                                         0,
                                                                         24,
                                                                         MEMORY_NAME));
    gameData.shareMemoryPointer = reinterpret_cast<char *>(MapViewOfFile(gameData.fileMapPointer, FILE_MAP_ALL_ACCESS, 0, 0, 0));
    if (gameData.shareMemoryPointer == nullptr)
        exit(1);
    else
    {
        gameData.mBlackChessBoard = reinterpret_cast<unsigned long long *>(gameData.shareMemoryPointer);
        gameData.mWhiteChessBoard = reinterpret_cast<unsigned long long *>(gameData.shareMemoryPointer + 1);
        gameData.mStartXInMemory = reinterpret_cast<signed char *>(gameData.shareMemoryPointer + 16);
        gameData.mStartYInMemory = reinterpret_cast<signed char *>(gameData.shareMemoryPointer + 17);
        gameData.mDestinationXInMemory = reinterpret_cast<signed char *>(gameData.shareMemoryPointer + 18);
        gameData.mDestinationYInMemory = reinterpret_cast<signed char *>(gameData.shareMemoryPointer + 19);
        gameData.mPlayerPtr = reinterpret_cast<signed char *>(gameData.shareMemoryPointer + 20);
        gameData.mStatePtr = reinterpret_cast<signed char *>(gameData.shareMemoryPointer + 24);
        *gameData.mStatePtr = 0;
        *gameData.mPlayerPtr = 0;
        *gameData.mStartXInMemory = -1;
        *gameData.mStartYInMemory = -1;
        *gameData.mDestinationXInMemory = -1;
        *gameData.mDestinationYInMemory = -1;
    }
}
void Register(QQmlApplicationEngine &engine)
{
    engine.rootContext()->setContextProperty("gameData", &gameData);
    engine.rootContext()->setContextProperty("tileData0", &(gameData.tileData[0][0]));
    engine.rootContext()->setContextProperty("tileData1", &(gameData.tileData[0][1]));
    engine.rootContext()->setContextProperty("tileData2", &(gameData.tileData[0][2]));
    engine.rootContext()->setContextProperty("tileData3", &(gameData.tileData[0][3]));
    engine.rootContext()->setContextProperty("tileData4", &(gameData.tileData[0][4]));
    engine.rootContext()->setContextProperty("tileData5", &(gameData.tileData[0][5]));
    engine.rootContext()->setContextProperty("tileData6", &(gameData.tileData[0][6]));
    engine.rootContext()->setContextProperty("tileData7", &(gameData.tileData[1][0]));
    engine.rootContext()->setContextProperty("tileData8", &(gameData.tileData[1][1]));
    engine.rootContext()->setContextProperty("tileData9", &(gameData.tileData[1][2]));
    engine.rootContext()->setContextProperty("tileData10", &(gameData.tileData[1][3]));
    engine.rootContext()->setContextProperty("tileData11", &(gameData.tileData[1][4]));
    engine.rootContext()->setContextProperty("tileData12", &(gameData.tileData[1][5]));
    engine.rootContext()->setContextProperty("tileData13", &(gameData.tileData[1][6]));
    engine.rootContext()->setContextProperty("tileData14", &(gameData.tileData[2][0]));
    engine.rootContext()->setContextProperty("tileData15", &(gameData.tileData[2][1]));
    engine.rootContext()->setContextProperty("tileData16", &(gameData.tileData[2][2]));
    engine.rootContext()->setContextProperty("tileData17", &(gameData.tileData[2][3]));
    engine.rootContext()->setContextProperty("tileData18", &(gameData.tileData[2][4]));
    engine.rootContext()->setContextProperty("tileData19", &(gameData.tileData[2][5]));
    engine.rootContext()->setContextProperty("tileData20", &(gameData.tileData[2][6]));
    engine.rootContext()->setContextProperty("tileData21", &(gameData.tileData[3][0]));
    engine.rootContext()->setContextProperty("tileData22", &(gameData.tileData[3][1]));
    engine.rootContext()->setContextProperty("tileData23", &(gameData.tileData[3][2]));
    engine.rootContext()->setContextProperty("tileData24", &(gameData.tileData[3][3]));
    engine.rootContext()->setContextProperty("tileData25", &(gameData.tileData[3][4]));
    engine.rootContext()->setContextProperty("tileData26", &(gameData.tileData[3][5]));
    engine.rootContext()->setContextProperty("tileData27", &(gameData.tileData[3][6]));
    engine.rootContext()->setContextProperty("tileData28", &(gameData.tileData[4][0]));
    engine.rootContext()->setContextProperty("tileData29", &(gameData.tileData[4][1]));
    engine.rootContext()->setContextProperty("tileData30", &(gameData.tileData[4][2]));
    engine.rootContext()->setContextProperty("tileData31", &(gameData.tileData[4][3]));
    engine.rootContext()->setContextProperty("tileData32", &(gameData.tileData[4][4]));
    engine.rootContext()->setContextProperty("tileData33", &(gameData.tileData[4][5]));
    engine.rootContext()->setContextProperty("tileData34", &(gameData.tileData[4][6]));
    engine.rootContext()->setContextProperty("tileData35", &(gameData.tileData[5][0]));
    engine.rootContext()->setContextProperty("tileData36", &(gameData.tileData[5][1]));
    engine.rootContext()->setContextProperty("tileData37", &(gameData.tileData[5][2]));
    engine.rootContext()->setContextProperty("tileData38", &(gameData.tileData[5][3]));
    engine.rootContext()->setContextProperty("tileData39", &(gameData.tileData[5][4]));
    engine.rootContext()->setContextProperty("tileData40", &(gameData.tileData[5][5]));
    engine.rootContext()->setContextProperty("tileData41", &(gameData.tileData[5][6]));
    engine.rootContext()->setContextProperty("tileData42", &(gameData.tileData[6][0]));
    engine.rootContext()->setContextProperty("tileData43", &(gameData.tileData[6][1]));
    engine.rootContext()->setContextProperty("tileData44", &(gameData.tileData[6][2]));
    engine.rootContext()->setContextProperty("tileData45", &(gameData.tileData[6][3]));
    engine.rootContext()->setContextProperty("tileData46", &(gameData.tileData[6][4]));
    engine.rootContext()->setContextProperty("tileData47", &(gameData.tileData[6][5]));
    engine.rootContext()->setContextProperty("tileData48", &(gameData.tileData[6][6]));
}
void ThrdFun()
{
    for (;;)
    {
        if (*gameData.mStatePtr != 4)
        {
            std::this_thread::sleep_for(std::chrono::milliseconds(500));
            continue;
        }
        else
            gameData.move(*gameData.mStartXInMemory, *gameData.mStartYInMemory, *gameData.mDestinationXInMemory, *gameData.mDestinationYInMemory);
    }
}
