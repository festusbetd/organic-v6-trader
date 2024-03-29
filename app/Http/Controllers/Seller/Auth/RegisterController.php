<?php

namespace App\Http\Controllers\Seller\Auth;

use App\CPU\ImageManager;
use App\Http\Controllers\Controller;
use App\Model\Seller;
use App\Model\Shop;
use Brian2694\Toastr\Facades\Toastr;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class RegisterController extends Controller
{
    public function create()
    {
        return view('seller-views.auth.register');
    }

    public function store(Request $request)
    {

        $this->validate($request, [
            'email' => 'required|unique:sellers',
            'shop_address' => 'required',
            'f_name' => 'required',
            'l_name' => 'required',
            'shop_name' => 'required',
            'phone' => 'required',
            'password' => 'required|min:8',
        ]);

        DB::transaction(function ($r) use ($request) {
            $seller = new Seller();
            $seller->f_name = $request->f_name;
            $seller->l_name = $request->l_name;
            $seller->phone = $request->phone;
            $seller->email = $request->email;
            $seller->id = $request->id_number;
            //added
   
            $seller->kra_pin= $request->kra_pin;
            $seller-> marital_status= $request->  marital_status ;
            $seller->other_phone_number= $request->other_phone_number ;
            $seller-> gender= $request->gender  ;
            $seller-> group_or_co_operative= $request->group_or_co_operative  ;
            $seller->  total_land_size= $request->total_land_size;
            $seller-> total_land_size_organic= $request->total_land_size_organic  ;
            $seller-> county= $request-> county ;
            $seller-> constituency= $request->constituency  ;
            $seller-> ward= $request->ward  ;
            $seller-> village= $request->  village ;  
            $seller-> user_type_name= $request-> user_type_name ;


            $seller->empoyee_number = $request->empoyee_number;
            $seller->image = ImageManager::upload('seller/', 'png', $request->file('image'));
            $seller->password = bcrypt($request->password);
            $seller->status = "pending";
            $seller->save();

            $shop = new Shop();
            $shop->seller_id = $seller->id;
            $shop->seller_id = $request->id_number;
            $shop->id = $request->id_number;
            $shop->name = $request->shop_name;
            $shop->address = $request->shop_address;
            $shop->contact = $request->phone;
            $shop->image = ImageManager::upload('shop/', 'png', $request->file('logo'));
            $shop->banner = ImageManager::upload('shop/banner/', 'png', $request->file('banner'));
            $shop->save();

            DB::table('seller_wallets')->insert([
                'seller_id' => $seller['id'],
                'withdrawn' => 0,
                'commission_given' => 0,
                'total_earning' => 0,
                'pending_withdraw' => 0,
                'delivery_charge_earned' => 0,
                'collected_cash' => 0,
                'created_at' => now(),
                'updated_at' => now(),
            ]);

        });

        Toastr::success('Shop apply successfully!');
        return redirect()->route('seller.auth.login');

    }
}
