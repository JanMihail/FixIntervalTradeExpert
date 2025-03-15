#include "Logger.mqh"
#include "Trade.mqh"

enum Direction { UP, DOWN } direction = UP;

namespace FixIntervalTradeExpert {

int OnInit() {
    Logger::info("Initialize...");
    Logger::info("Initialize complete!");
    return (INIT_SUCCEEDED);
}

void OnDeinit(const int reason) {
    Logger::info("Deinitialize...");
    Logger::info("Deinitialize complete! ReasonCode: " + IntegerToString(reason));
}

void OnTick() {
    if (PositionsTotal() > 0) {
        closeLogic();
        return;
    }

    openLogic();
}

void openLogic() {
    MqlDateTime curTime = getCurrentTime();

    if (!(curTime.hour == 17 && curTime.min == 0)) {
        return;
    }

    bool res;
    if (direction == UP) {
        res = Trade::openLong();
    } else {
        res = Trade::openShort();
    }

    if (res) {
        direction = direction == UP ? DOWN : UP;
    }
}

void closeLogic() {
    MqlDateTime curTime = getCurrentTime();

    if (!(curTime.hour == 21 && curTime.min == 0)) {
        return;
    }

    Trade::closeCurrentPosition();
}

MqlDateTime getCurrentTime() {
    datetime currentCandleTime = iTime(Symbol(), PERIOD_M5, 0);

    MqlDateTime dateTimeStruct = {};

    if (!TimeToStruct(currentCandleTime, dateTimeStruct)) {
        Logger::printLastError(__FUNCSIG__, __LINE__);
        return dateTimeStruct;
    }

    return dateTimeStruct;
}

}