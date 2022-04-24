#ifndef GAME_DATA_H
#define GAME_DATA_H
#include "TileData.h"
#include <QObject>
#include <fstream>
class GameData : public QObject
{
    Q_OBJECT
public:
    Q_PROPERTY(int state READ getState WRITE setState NOTIFY stateChanged);
    Q_PROPERTY(int player READ getPlayer WRITE setPlayer NOTIFY playerChanged);
    Q_PROPERTY(int startX READ getStartX WRITE setStartX NOTIFY startXChanged);
    Q_PROPERTY(int startY READ getStartY WRITE setStartY NOTIFY startYChanged);
    Q_PROPERTY(bool enableTimer READ getEnableTimer WRITE setEnableTimer NOTIFY enableTimerChanged);
    Q_PROPERTY(int seconds READ getSeconds WRITE setSeconds NOTIFY secondsChanged);
    Q_PROPERTY(int minutes READ getMinutes WRITE setMinutes NOTIFY minutesChanged);
    Q_PROPERTY(int steps READ getSteps WRITE setSteps NOTIFY stepsChanged);
    int getState();
    int getPlayer();
    int getStartX();
    int getStartY();
    int getSeconds();
    int getMinutes();
    int getSteps();
    bool getEnableTimer();
    void setState(int opt);
    void setPlayer(int opt);
    void setStartX(int opt);
    void setStartY(int opt);
    void setSeconds(int opt);
    void setMinutes(int opt);
    void setSteps(int opt);
    void setEnableTimer(bool opt);
    int judgeWinner();
    Q_INVOKABLE void start(bool load, bool pvp, bool aiFirst);
    Q_INVOKABLE void save();
    Q_INVOKABLE void move(int startX, int startY, int destinationX, int destinationY);
    Q_INVOKABLE void secondsPlus();
    Q_INVOKABLE void clean();
    TileData tileData[7][7];
    char *shareMemoryPointer{nullptr};
    char *fileMapPointer{nullptr};
    unsigned long long *mBlackChessBoard{nullptr};
    unsigned long long *mWhiteChessBoard{nullptr};
    signed char *mStartXInMemory{nullptr};
    signed char *mStartYInMemory{nullptr};
    signed char *mDestinationXInMemory{nullptr};
    signed char *mDestinationYInMemory{nullptr};
    signed char *mStatePtr{nullptr};
    signed char *mPlayerPtr{nullptr};
signals:
    void stateChanged();
    void playerChanged();
    void startXChanged();
    void startYChanged();
    void secondsChanged();
    void minutesChanged();
    void enableTimerChanged();
    void stepsChanged();

private:
    bool personVsPerson{false};
    bool mEnableTimer{false};
    int mSteps{0};
    int mSeconds{0}, mMinutes{0};
};
#endif // GAME_DATA_H
