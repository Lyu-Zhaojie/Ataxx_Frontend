#ifndef TILE_DATA_H
#define TILE_DATA_H
#include <QObject>
class TileData : public QObject
{
    Q_OBJECT
public:
    Q_PROPERTY(int state READ getState NOTIFY stateChanged);
    int getState();
    void setState(int state);

    int mState{3};
signals:
    void stateChanged();
};
#endif // TILE_DATA_H
