<?php
namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class OrderCancelled extends Mailable
{
    use Queueable, SerializesModels;

    protected $name;
    protected $email;
    protected $phone;
    protected $order_id;
    protected $product_name;
    protected $quantity;
    protected $price;
    protected $total_price;
    protected $shipping_cost;
    protected $status;
    protected $date;
    protected $street;
    protected $city;
    protected $code;
    protected $country;

    public function __construct(
        $name,
        $email,
        $phone,
        $order_id,
        $product_name,
        $quantity,
        $price,
        $total_price,
        $shipping_cost,
        $status,
        $date,
        $street,
        $city,
        $code,
        $country
    ) {
        $this->name = $name;
        $this->email = $email;
        $this->phone = $phone;
        $this->order_id = $order_id;
        $this->product_name = $product_name;
        $this->quantity = $quantity;
        $this->price = $price;
        $this->total_price = $total_price;
        $this->shipping_cost = $shipping_cost;
        $this->status = $status;
        $this->date = $date;
        $this->street = $street;
        $this->city = $city;
        $this->code = $code;
        $this->country = $country;
    }

    public function build()
    {
        $name = $this->name;
        $email = $this->email;
        $phone = $this->phone;
        $order_id = $this->order_id;
        $product_name = $this->product_name;
        $quantity = $this->quantity;
        $price = $this->price;
        $total_price = $this->total_price;
        $shipping_cost = $this->shipping_cost;
        $status = $this->status;
        $date = $this->date;
        $street = $this->street;
        $city = $this->city;
        $code = $this->code;
        $country = $this->country;

        return $this->view("email-templates.order-cancelled", [
            "name" => $name,
            "email" => $email,
            "phone" => $phone,
            "id" => $order_id,
            "product_name" => $product_name,
            "quantity" => $quantity,
            "price" => $price,
            "total_price" => $total_price,
            "shipping_cost" => $shipping_cost,
            "status" => $status,
            "date" => $date,
            "street" => $street,
            "city" => $city,
            "code" => $code,
            "country" => $country,
        ]);
    }
}
