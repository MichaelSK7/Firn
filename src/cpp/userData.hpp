#pragma once

#include <QObject>

class foo : public QObject {
    Q_OBJECT

  public:
    explicit foo(QObject* parent = nullptr);

  public slots:
    void callMe();
};