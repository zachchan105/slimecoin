// Copyright (c) 2011-2014 The Bitcoin Core developers
// Copyright (c) 2017-2019 The Slimecoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef SLIMECOIN_QT_SLIMECOINADDRESSVALIDATOR_H
#define SLIMECOIN_QT_SLIMECOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class SlimecoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit SlimecoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Slimecoin address widget validator, checks for a valid slimecoin address.
 */
class SlimecoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit SlimecoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // SLIMECOIN_QT_SLIMECOINADDRESSVALIDATOR_H
