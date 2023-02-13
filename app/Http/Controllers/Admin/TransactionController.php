<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Support\Facades\DB;
use App\CPU\Helpers;
use App\Http\Controllers\Controller;
use App\Model\OrderTransaction;
use App\Model\Transaction;
use Illuminate\Http\Request;

class TransactionController extends Controller
{
    public function list(Request $request)
    {
        $query_param = [];
        $search = $request['search'];
        if ($request->has('search'))
        {
            $key = explode(' ', $request['search']);
            $transactions = OrderTransaction::with(['seller','customer'])->where(function ($q) use ($key) {
                foreach ($key as $value) {
                    $q->orWhere('order_id', 'like', "%{$value}%")
                        ->orWhere('transaction_id', 'like', "%{$value}%");
                }
            });
            $query_param = ['search' => $request['search']];
        }else{
            $transactions = OrderTransaction::with(['seller','customer']);
        }
        $status = $request['status'];
        if ($request->has('status'))
        {
            $key = explode(' ', $request['status']);
            $transactions = $transactions->where(function ($q) use ($key) {
                foreach ($key as $value) {
                    $q->Where('status', 'like', "%{$value}%");
                }
            });
            $query_param = ['status' => $request['status']];
        }

        $transactions = $transactions->latest()->paginate(Helpers::pagination_limit())->appends($query_param);

        return view('admin-views.transaction.list', compact('transactions','search','status'));
    }
    public function mpesa_list(Request $request)
    {
      
        //     $transaction = DB::Table("mpesa_transactions")->where(function ($q) use ($key) {
    
        // return view('admin-views.transaction.mpesa-list', compact('transactions','search','status'));

        $query_param = [];
        $search = $request['search'];
        if ($request->has('search'))
        {
            $key = explode(' ', $request['search']);
            $transactions = OrderTransaction::where(function ($q) use ($key) {
                foreach ($key as $value) {
                    $q->orWhere('order_id', 'like', "%{$value}%")
                        ->orWhere('transaction_id', 'like', "%{$value}%");
                }
            });
            $query_param = ['search' => $request['search']];
        }else{
            $transactions = OrderTransaction::with(['seller','customer']);
        }
        $status = $request['status'];
        if ($request->has('status'))
        {
            $key = explode(' ', $request['status']);
            $transactions = $transactions->where(function ($q) use ($key) {
                foreach ($key as $value) {
                    $q->Where('status', 'like', "%{$value}%");
                }
            });
            $query_param = ['status' => $request['status']];
        }

        $transactions = $transactions->latest()->paginate(Helpers::pagination_limit())->appends($query_param);

        return view('admin-views.transaction.mpesa-list', compact('transactions','search','status'));
    }
}
