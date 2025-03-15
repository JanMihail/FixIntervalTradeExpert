//###<Experts/FixIntervalTradeExpert/FixIntervalTradeExpert.mq5>

#include "Logger.mqh"
#include <Trade/Trade.mqh>

namespace FixIntervalTradeExpert {

class Trade {

public:
    static bool openLong() {
        CTrade trade;
        bool res = trade.Buy(0.01, Symbol());

        if (!res) {
            Logger::printLastError(__FUNCSIG__, __LINE__);
        }

        return res;
    }

    static bool openShort() {
        CTrade trade;
        bool res = trade.Sell(0.01, Symbol());

        if (!res) {
            Logger::printLastError(__FUNCSIG__, __LINE__);
        }

        return res;
    }

    static bool closeCurrentPosition() {
        CTrade trade;
        return trade.PositionClose(Symbol());
    }
};

}