@extends('layouts.back-end.app-seller')

@section('title','User List')

@push('css_or_js')
    <style>
        .switch {
            position: relative;
            display: inline-block;
            width: 48px;
            height: 23px;
        }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            -webkit-transition: .4s;
            transition: .4s;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 15px;
            width: 15px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            -webkit-transition: .4s;
            transition: .4s;
        }

        input:checked + .slider {
            background-color: #377dff;
        }

        input:focus + .slider {
            box-shadow: 0 0 1px #377dff;
        }

        input:checked + .slider:before {
            -webkit-transform: translateX(26px);
            -ms-transform: translateX(26px);
            transform: translateX(26px);
        }

        /* Rounded sliders */
        .slider.round {
            border-radius: 34px;
        }

        .slider.round:before {
            border-radius: 50%;
        }

    </style>
@endpush

@section('content')
    <div class="content container-fluid">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="{{route('seller.dashboard.index')}}">{{\App\CPU\translate('Dashboard')}}</a>
                </li>
                <li class="breadcrumb-item" aria-current="page">Sellers Users</li>

            </ol>
        </nav>

        <div class="row">
            <div class="col-md-12">
            <div class="card">
                    <div class="card-header">
                        <div class="row row justify-content-between align-items-center flex-grow-1 mx-1">
                            <div class="flex-between">
                                <div><h5>{{\App\CPU\translate('seller_table')}}</h5></div>
                                <div class="mx-1"><h5 style="color: red;">({{ $sellers->total() }})</h5></div>
                            </div>
                            <div style="width: 40vw">
                                <!-- Search -->
                                <!-- <form action="{{ url()->current() }}" method="GET">
                                    <div class="input-group input-group-merge input-group-flush">
                                        <div class="input-group-prepend">
                                            <div class="input-group-text">
                                                <i class="tio-search"></i>
                                            </div>
                                        </div>
                                        <input id="datatableSearch_" type="search" name="search" class="form-control"
                                            placeholder="Search by Name or Phone or Email" aria-label="Search orders" value="{{ $search }}" required>
                                        <button type="submit" class="btn btn-primary">search</button>
                                    </div>
                                </form> -->

                            
                                <!-- End Search -->
                            
                        <div class="row justify-content-between align-items-center flex-grow-1">
                            <div class="col-lg-2"></div>
                            <div class="col-lg-6 mb-3 mb-lg-0">
                                <form action="{{ url()->current() }}" method="GET">
                                    <!-- Search -->
                                    <div class="input-group input-group-merge input-group-flush">
                                        <div class="input-group-prepend">
                                            <div class="input-group-text">
                                                <i class="tio-search"></i>
                                            </div>
                                        </div>
                                        <input id="datatableSearch_" type="search" name="search" class="form-control"
                                            placeholder="Search by Product Name" aria-label="Search orders" value="{{ $search }}" required>
                                        <button type="submit" class="btn btn-primary">search</button>
                                    </div>
                                    <!-- End Search -->
                                </form>
                            </div>
                            <div class="col-lg-4">
                                <a href="{{route('seller.user.add-new-user')}}" class="btn btn-primary float-{{Session::get('direction') === "rtl" ? 'left' : 'right'}}">
                                    <i class="tio-add-circle"></i>
                                    <span class="text">{{\App\CPU\translate('Add new Employee')}}</span>
                                </a>
                            </div>
                        </div>


                            </div>
                        </div>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table
                                style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                                class="table table-borderless table-thead-bordered table-nowrap table-align-middle card-table">
                                <thead class="thead-light">
                                <tr>
                                    <th scope="col">{{\App\CPU\translate('SL#')}}</th>
                                    <th scope="col">{{\App\CPU\translate('ID')}}</th>
                                    <th scope="col">{{\App\CPU\translate('name')}}</th>
                                    <th scope="col">{{\App\CPU\translate('Phone')}}</th>
                                    <th scope="col">{{\App\CPU\translate('Email')}}</th>
                                    <th scope="col">Empoyee Number</th>
                                    <th scope="col">{{\App\CPU\translate('status')}}</th>
                                 
                                 
                                    <th scope="col" style="width: 50px">{{\App\CPU\translate('action')}}</th>
                                </tr>
                                </thead>
                                <tbody>
                                @foreach($sellers as $key=>$seller)
                                    <tr>
                                        <td scope="col">{{$sellers->firstItem()+$key}}</td>
                                        <td scope="col">{{$seller->id}}</td>
                                        <td scope="col">{{$seller->f_name}} {{$seller->l_name}}</td>
                                        <td scope="col">{{$seller->phone}}</td>
                                        <td scope="col">{{$seller->email}}</td>
                                        <td scope="col">{{$seller->empoyee_number}}</td>
                                        <td scope="col">
                                            {!! $seller->status=='approved'?'<label class="badge badge-success">Active</label>':'<label class="badge badge-danger">In-Active</label>' !!}
                                        </td>
                                     
                                        <td>
                                            <a class="btn btn-primary"
                                               href="">
                                                {{\App\CPU\translate('Refresh')}}
                                            </a>
                                        </td>
                                    </tr>
                                @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="card-footer">
                        {!! $sellers->links() !!}
                    </div>
                    @if(count($sellers)==0)
                        <div class="text-center p-4">
                            <img class="mb-3" src="{{asset('public/assets/back-end')}}/svg/illustrations/sorry.svg" alt="Image Description" style="width: 7rem;">
                            <p class="mb-0">No data to show</p>
                        </div>
                    @endif
                </div>
            </div>
        </div>
    </div>
@endsection

@push('script')
    <!-- Page level plugins -->
    <script src="{{asset('public/assets/back-end')}}/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="{{asset('public/assets/back-end')}}/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <script>
        // Call the dataTables jQuery plugin
        $(document).ready(function () {
            $('#dataTable').DataTable();
        });

        $(document).on('change', '.status', function () {
            var id = $(this).attr("id");
            if ($(this).prop("checked") == true) {
                var status = 1;
            } else if ($(this).prop("checked") == false) {
                var status = 0;
            }
            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                }
            });
            $.ajax({
                url: "{{route('seller.product.status-update')}}",
                method: 'POST',
                data: {
                    id: id,
                    status: status
                },
                success: function (data) {
                    if(data.success == true) {
                        toastr.success('Status updated successfully');
                    }
                    else if(data.success == false) {
                        toastr.error('Status updated failed. Product must be approved');
                        location.reload();
                    }
                }
            });
        });
    </script>
@endpush
