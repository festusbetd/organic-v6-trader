<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;

class MpesaTransaction extends Model
{

    protected $fillable = [
        'TransactionType',
        'TransID',
        'TransTime',
        'TransAmount',
        'BusinessShortCode',
        'BillRefNumber',
        'InvoiceNumber',
        'resultCode',
        'resultDesc',
        'AccountReference',
        'OrgAccountBalance',
        'ThirdPartyTransID',
        'MSISDN',
        'FirstName',
        'MiddleName',
        'LastName',
    ];
}