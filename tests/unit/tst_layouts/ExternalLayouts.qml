/*
 * Copyright 2013 Canonical Ltd.
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
 */

import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Layouts 0.1

Item {
    id: root
    width: units.gu(40)
    height: units.gu(30)

    Layouts {
        objectName: "layouts"
        id: layouts
        anchors.fill: parent
        layouts: [
            SmallLayout{},
            MediumLayout {},
            LargeLayout {}
        ]

        // default layout
        Label {
            objectName: "item1"
            id: label1
            ConditionalLayout.name: "item1"
            text: "item1"
        }
        Label {
            objectName: "item2"
            id: label2
            anchors.bottom: label1.bottom
            ConditionalLayout.name: "item1"
            text: "item2"
        }
        Label {
            objectName: "item3"
            id: label3
            anchors.bottom: label2.bottom
            ConditionalLayout.name: "item1"
            text: "item3"
        }
    }
}
