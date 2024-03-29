@extends('layouts.back-end.app')

@section('content')
    <div class="content container-fluid ">
        <div class="col-md-4" style="margin-bottom: 20px;">
            <h3 class="text-capitalize">{{ \App\CPU\translate('transaction_table')}}
       

            </h3>
        </div>
        {{-- <div class="row" style="margin-top: 20px"> --}}
        {{-- <div class="col-md-12"> --}}
        <div class="card">
            <div class="card-header">
                <div class="flex-between justify-content-between align-items-center flex-grow-1">
                    <div class="col-md-5 ">
                        <form action="{{ url()->current() }}" method="GET">
                            <!-- Search -->
                            <div class="input-group input-group-merge input-group-flush">
                                <div class="input-group-prepend">
                                    <div class="input-group-text">
                                        <i class="tio-search"></i>
                                    </div>
                                </div>
                                <input id="datatableSearch_" type="search" name="search" class="form-control"
                                       placeholder="Search by orders id or transaction id" aria-label="Search orders"
                                       value="{{ $search }}"
                                       required>
                                <button type="submit" class="btn btn-primary">{{ \App\CPU\translate('search')}}</button>
                            </div>
                            <!-- End Search -->
                        </form>
                    </div>
                    <form action="{{ url()->current() }}" method="GET">
                        <div class="row">

                            <div class="col-md-8">

                                <select class="form-control" name="status">

                                    <option class="text-center" value="0" selected disabled>
                                        ---{{\App\CPU\translate('select_status')}}---
                                    </option>
                                    <option class="text-left text-capitalize"
                                            value="disburse" {{ $status == 'disburse'? 'selected' : '' }} >{{\App\CPU\translate('disburse')}} </option>
                                    <option class="text-left text-capitalize"
                                            value="hold" {{ $status == 'hold'? 'selected' : '' }}>{{\App\CPU\translate('hold')}}</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <button type="submit" class="btn btn-success">{{\App\CPU\translate('filter')}}</button>
                            </div>

                        </div>
                    </form>
                </div>
            </div>
            <div class="card-body" style="padding: 0">
                <div class="table-responsive">
                    <table id="datatable"
                           style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                           class="table table-hover table-borderless table-thead-bordered table-nowrap table-align-middle card-table">
                        <thead class="thead-light">
                        <tr>
                            <th>{{\App\CPU\translate('SL#')}}</th>
                    
                            <th>{{\App\CPU\translate('id')}}</th>
                            <th>{{\App\CPU\translate('customer_name')}}</th>
                            <th>{{\App\CPU\translate('order_id')}}</th>
                            <th>{{\App\CPU\translate('transaction_id')}}</th>
                            <th>{{\App\CPU\translate('order_amount')}}</th>
                            <th>{{ \App\CPU\translate('seller_amount') }}</th>
                            <th>{{\App\CPU\translate('admin_commission')}}</th>
                            <th>{{\App\CPU\translate('received_by')}}</th>
                            <th>{{\App\CPU\translate('delivered_by')}}</th>
                            <th>{{\App\CPU\translate('delivery_charge')}}</th>
                            <th>{{\App\CPU\translate('payment_method')}}</th>
                            <th>{{\App\CPU\translate('tax')}}</th>
                            <th>{{\App\CPU\translate('status')}}</th>
                        </tr>
                        </thead>
                        <tbody>
                        @foreach($transactions as $key=>$transaction)
                            <tr>
                                <td>{{$transactions->firstItem()+$key}}</td>
                                <td>{{$transaction['id']}}</td> 
                                <td>{{$transaction['id']}}</td> 
                                <td>{{$transaction['id']}}</td> 
                                <td>{{$transaction['id']}}</td> 
                                <td>{{$transaction['id']}}</td> 
                                <td>{{$transaction['id']}}</td> 
                                <td>{{$transaction['id']}}</td> 
                                <td>{{$transaction['id']}}</td> 
                                <td>{{$transaction['id']}}</td> 
                                <td>{{$transaction['id']}}</td> 
                                <td>{{$transaction['id']}}</td> 
                                <td>{{$transaction['id']}}</td> 
                                <td>{{$transaction['id']}}</td> 
                               
                            </tr>
                        @endforeach

                        </tbody>
                    </table>
                    @if(count($transactions)==0)
                        <div class="text-center p-4">
                            <img class="mb-3" src="{{asset('public/assets/back-end')}}/svg/illustrations/sorry.svg"
                                 alt="Image Description" style="width: 7rem;">
                            <p class="mb-0">{{ \App\CPU\translate('No_data_to_show')}}</p>
                        </div>
                    @endif
                </div>
            </div>
            <div class="card-footer">
                {{$transactions->links()}}
            </div>

        </div>
        {{-- </div> --}}

        {{-- </div> --}}
    </div>
@endsection
