<?php

namespace App\Mail;

use App\Util\Tool;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class RegisterEmail extends Mailable
{
    use Queueable, SerializesModels;

    public $verificationCode;

    /**
     * registerEmail constructor.
     *
     * @param string $verificationCode
     */
    public function __construct($verificationCode = '')
    {
        $this->verificationCode = ($verificationCode == '')?Tool::getVerificationCode():$verificationCode;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('email.register_email')->subject('Welcome Register TDBlog');
    }
}
