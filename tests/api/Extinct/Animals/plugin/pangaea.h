/*
 * Copyright 2015 Canonical Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#ifndef EA_PANGAEA_H
#define EA_PANGAEA_H

#include <QtCore/QObject>

class EAPangaea : public QObject
{
    Q_OBJECT
    Q_ENUMS(ModernContinent)

public:
    static EAPangaea& instance() {
        static EAPangaea instance;
        return instance;
    }

    enum ModernContinent {
        America,
        Europe,
    };
    explicit EAPangaea(QObject *parent = 0);
};

class EAPangaea4 : public EAPangaea
{
    Q_OBJECT
    Q_PROPERTY(quint16 toolkitVersion READ toolkitVersion NOTIFY toolkitVersionChanged REVISION 1)
public:
    explicit EAPangaea4(QObject *parent = 0) : EAPangaea(parent)
    {
    }

    Q_INVOKABLE quint16 version(quint8 major, quint8 minor);

Q_SIGNALS:
    void toolkitVersionChanged();

protected:
    virtual quint16 toolkitVersion() const
    {
        return 0;
    }
    quint16 toolkitVersionMajor() const
    {
        return 0;
    }
    quint16 toolkitVersionMinor() const
    {
        return 0;
    }
};

#endif // EA_PANGAEA_H
