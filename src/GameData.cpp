#include "GameData.h"
#include <cmath>

int GameData::getState() { return *mStatePtr; }
int GameData::getPlayer() { return *mPlayerPtr; }
int GameData::getStartX() { return *mStartXInMemory; }
int GameData::getStartY() { return *mStartYInMemory; }
int GameData::getSeconds() { return mSeconds; }
int GameData::getMinutes() { return mMinutes; }
int GameData::getSteps() { return mSteps; }
bool GameData::getEnableTimer() { return mEnableTimer; }
void GameData::setState(int opt)
{
    if (*mStatePtr == opt)
        return;
    *mStatePtr = opt;
    emit stateChanged();
}
void GameData::setPlayer(int opt)
{
    if (*mPlayerPtr == opt)
        return;
    *mPlayerPtr = opt;
    emit playerChanged();
}
void GameData::setStartX(int opt)
{
    if (*mStartXInMemory == opt)
        return;
    *mStartXInMemory = opt;
    emit startXChanged();
}
void GameData::setStartY(int opt)
{
    if (*mStartYInMemory == opt)
        return;
    *mStartYInMemory = opt;
    emit startYChanged();
}
void GameData::setSeconds(int opt)
{
    if (mSeconds == opt)
        return;
    mSeconds = opt;
    emit secondsChanged();
}
void GameData::setMinutes(int opt)
{
    if (mMinutes == opt)
        return;
    mMinutes = opt;
    emit minutesChanged();
}
void GameData::setEnableTimer(bool opt)
{
    if (mEnableTimer == opt)
        return;
    mEnableTimer = opt;
    emit enableTimerChanged();
}
void GameData::setSteps(int opt)
{
    if (mSteps == opt)
        return;
    mSteps = opt;
    emit stepsChanged();
}
int GameData::judgeWinner()
{
    int nMoveBlack{0}, nMoveWhite{0};
    int nBlack{0}, nWhite{0};
    for (int i{0}; i < 7; i++)
    {
        for (int j{0}; j < 7; j++)
        {
            if (tileData[i][j].mState == 0)
            {
                nBlack++;
                for (int k{i - 2}; k <= i + 2; k++)
                {
                    for (int l{j - 2}; l <= j + 2; l++)
                    {
                        if (k >= 0 && k <= 6 && l >= 0 && l <= 6 && tileData[k][l].mState == 3)
                            nMoveBlack++;
                    }
                }
            }
            else if (tileData[i][j].mState == 1)
            {
                nWhite++;
                for (int k{i - 2}; k <= i + 2; k++)
                {
                    for (int l{j - 2}; l <= j + 2; l++)
                    {
                        if (k >= 0 && k <= 6 && l >= 0 && l <= 6 && tileData[k][l].mState == 3)
                            nMoveWhite++;
                    }
                }
            }
        }
    }
    if (nMoveBlack == 0)
        return 49 - nBlack > 24 ? 6 : 5;
    if (nMoveWhite == 0)
        return 49 - nWhite > 24 ? 5 : 6;
    return 0;
}
Q_INVOKABLE void GameData::start(bool load, bool pvp, bool aiFirst)
{
    unsigned long long blackBoard{0ULL}, whiteBoard{0ULL};
    if (load)
    {
        char tmp[16]{};
        int steps{}, seconds{}, minutes{}, player{}, _pvp{};
        std::ifstream loadFile("data.wzqtql", std::ios::in);
        loadFile >> tmp >> blackBoard >> tmp >> whiteBoard >> tmp >> steps >> tmp >> minutes >> tmp >> seconds >> tmp >> player >> tmp >> _pvp;
        setSteps(steps);
        setMinutes(minutes);
        setSeconds(seconds);
        setPlayer(player);
        personVsPerson = _pvp;
        *mBlackChessBoard = blackBoard;
        *mWhiteChessBoard = whiteBoard;
        loadFile.close();
    }
    else
    {
        blackBoard = 0b00000000'01000000'00000000'00000000'00000000'00000000'00000000'00000001;
        whiteBoard = 0b00000000'00000001'00000000'00000000'00000000'00000000'00000000'01000000;
        *mBlackChessBoard = blackBoard;
        *mWhiteChessBoard = whiteBoard;
    }
    bool tempBlack{false}, tempWhite{false};
    for (int i{0}; i < 7; i++)
    {
        for (int j{0}; j < 7; j++)
        {
            tempBlack = 1ULL & (blackBoard >> (i << 3 | j));
            tempWhite = 1ULL & (whiteBoard >> (i << 3 | j));
            if (tempBlack)
                tileData[i][j].setState(0);
            else if (tempWhite)
                tileData[i][j].setState(1);
            else
                tileData[i][j].setState(3);
        }
    }
    setEnableTimer(true);
    if (load)
        setState(1);
    else
    {
        if (!pvp)
        {
            personVsPerson = false;
            if (aiFirst)
                setState(3);
            else
                setState(1);
        }
        else
        {
            personVsPerson = true;
            setState(1);
        }
    }
}
Q_INVOKABLE void GameData::save()
{
    std::ofstream outFile("data.wzqtql", std::ios::out);
    unsigned long long black{0}, white{0};
    for (int i{0}; i < 7; i++)
    {
        for (int j{0}; j < 7; j++)
        {
            if (tileData[i][j].mState == 0)
                black |= 1ULL << (i << 3 | j);
            if (tileData[i][j].mState == 1)
                white |= 1ULL << (i << 3 | j);
        }
    }
    outFile << "black: " << black << std::endl
            << "white: " << white << std::endl
            << "steps: " << mSteps << std::endl
            << "minutes: " << mMinutes << std::endl
            << "seconds: " << mSeconds << std::endl
            << "player: " << (int)(*mPlayerPtr) << std::endl
            << "pvp: " << (int)personVsPerson << std::endl;
    outFile.close();
}
Q_INVOKABLE void GameData::move(int startX, int startY, int destinationX, int destinationY)
{
    bool typeR2{(std::abs(startX - destinationX) == 2 && std::abs(startY - destinationY) <= 2) || (std::abs(startX - destinationX) <= 2 && std::abs(startY - destinationY) == 2)};
    if (typeR2)
        tileData[startX][startY].setState(3);
    tileData[destinationX][destinationY].setState(*mPlayerPtr);
    for (int i{destinationX - 1}; i <= destinationX + 1; i++)
    {
        for (int j{destinationY - 1}; j <= destinationY + 1; j++)
        {
            if (i >= 0 && i <= 6 && j >= 0 && j <= 6 && tileData[i][j].getState() == 1 - *mPlayerPtr)
                tileData[i][j].setState(*mPlayerPtr);
        }
    }
    setSteps(mSteps + 1);
    int nextState = judgeWinner();
    setPlayer(1 - *mPlayerPtr);
    if (nextState > 4)
    {
        setState(nextState);
        setEnableTimer(false);
    }
    else
    {
        if (personVsPerson)
            setState(1);
        else
        {
            if (getState() == 4)
                setState(1);
            else if (getState() == 2)
            {
                *mStartXInMemory = startX;
                *mStartYInMemory = startY;
                *mDestinationXInMemory = destinationX;
                *mDestinationYInMemory = destinationY;
                setState(3);
            }
        }
    }
}
Q_INVOKABLE void GameData::secondsPlus()
{
    mSeconds++;
    if (mSeconds == 60)
    {
        mSeconds = 0;
        mMinutes++;
        emit minutesChanged();
    }
    emit secondsChanged();
}
Q_INVOKABLE void GameData::clean()
{
    setState(0);
    setEnableTimer(0);
    setSeconds(0);
    setMinutes(0);
    setSteps(0);
    setPlayer(0);
    setStartX(-1);
    setStartY(-1);
    *mDestinationXInMemory = -1;
    *mDestinationYInMemory = -1;
}
